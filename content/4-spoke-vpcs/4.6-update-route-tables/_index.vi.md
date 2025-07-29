---
title : "Update Route Tables với Transit Gateway"
date :  "2025-07-13" 
menu : "main"
weight : 6
chapter : false
pre : " <b> 4.6 </b> "
---

## Bước 8: Update Route Tables với Transit Gateway

Sau khi attachments được tạo, update route tables. **Lưu ý:** Khi thêm route trong Bảng Định Tuyến VPC, Target phải là **ID của Transit Gateway** (`tgw-xxxxxxxxxxxxxxxxx`), không phải ID của Attachment.

### 8.1 Update Hub VPC Route Tables

1. Chọn **Hub-TGW-RT** (Bảng Định Tuyến VPC trong Hub VPC, liên kết với các TGW Subnet của Hub)
2. Edit routes, add:

![](/images/4.spoke-vpcs/hinh-61.png)
```
- 10.1.0.0/16 → tgw-xxxxxxxxxxxxxxxxx (ID của Hub-TGW, to Production)
- 10.2.0.0/16 → tgw-xxxxxxxxxxxxxxxxx (ID của Hub-TGW, to Development)
- 0.0.0.0/0 → tgw-xxxxxxxxxxxxxxxxx (ID của Hub-TGW, nếu muốn lưu lượng internet từ Spoke VPC đi qua Hub)
```
![](/images/4.spoke-vpcs/hinh-62.png)
### 8.2 Update Spoke VPC Route Tables

Update tất cả route tables trong Production và Development VPCs để point default route (0.0.0.0/0) tới Transit Gateway, và các route đến Hub VPC/Spoke VPC khác.
#### Đối với Production VPC Route Tables (Prod-App-RT, Prod-DB-RT, Prod-TGW-RT):

```
- 0.0.0.0/0 → tgw-xxxxxxxxxxxxxxxxx (ID của Hub-TGW)
- 10.0.0.0/16 → tgw-xxxxxxxxxxxxxxxxx (ID của Hub-TGW, to Hub)
- 10.2.0.0/16 → tgw-xxxxxxxxxxxxxxxxx (ID của Hub-TGW, to Dev, nếu cần)
```
![](/images/4.spoke-vpcs/hinh-63.png)
![](/images/4.spoke-vpcs/hinh-64.png)
![](/images/4.spoke-vpcs/hinh-65.png)
#### Đối với Development VPC Route Tables (Dev-App-RT, Dev-DB-RT, Dev-TGW-RT):

```
- 0.0.0.0/0 → tgw-xxxxxxxxxxxxxxxxx (ID của Hub-TGW)
- 10.0.0.0/16 → tgw-xxxxxxxxxxxxxxxxx (ID của Hub-TGW, to Hub)
- 10.1.0.0/16 → tgw-xxxxxxxxxxxxxxxxx (ID của Hub-TGW, to Prod, nếu cần)
```
![](/images/4.spoke-vpcs/hinh-66.png)
![](/images/4.spoke-vpcs/hinh-67.png)
![](/images/4.spoke-vpcs/hinh-68.png)