---
title : "Attach Spoke VPCs tới Transit Gateway"
date :  "2025-07-13" 
menu : "main"
weight : 3
chapter : false
pre : " <b> 4.3 </b> "
---

## Bước 5: Attach Spoke VPCs tới Transit Gateway

### 5.1 Attach Production VPC

1. Trong VPC Console, chọn **Transit Gateway Attachments**
2. Click **Create Transit Gateway Attachment**
3. Cấu hình:

```
Name tag: Prod-VPC-TGW-Attachment
Transit Gateway ID: Hub-TGW
Attachment type: VPC
VPC ID: Production-VPC
Subnet IDs: 
  - Prod-TGW-Subnet-1a
  - Prod-TGW-Subnet-1b
```
![](/images/4.spoke-vpcs/hinh-33.png)
![](/images/4.spoke-vpcs/hinh-34.png)
4. Click **Create Transit Gateway Attachment**

### 5.2 Attach Development VPC

```
Name tag: Dev-VPC-TGW-Attachment
Transit Gateway ID: Hub-TGW
Attachment type: VPC
VPC ID: Development-VPC
Subnet IDs: 
  - Dev-TGW-Subnet-1a
  - Dev-TGW-Subnet-1b
```
![](/images/4.spoke-vpcs/hinh-35.png)
![](/images/4.spoke-vpcs/hinh-36.png)
### 5.3 Associate với Spoke Route Table

1. Chọn **Transit Gateway Route Tables**
2. Select **Spoke-Route-Table**
3. Click **Associations** tab
4. Click **Create association**
5. Associate cả Production và Development VPC attachments

![](/images/4.spoke-vpcs/hinh-37.png)
![](/images/4.spoke-vpcs/hinh-38.png)
### 5.4 Thêm Default Route vào Spoke Route Table

Đây là một bước cực kỳ quan trọng để cho phép các Spoke VPC truy cập internet. Bạn cần phải "dạy" cho Transit Gateway biết rằng tất cả traffic đi ra internet (`0.0.0.0/0`) phải được chuyển đến Hub VPC.

1.  Trong **Transit Gateway Route Tables**, chọn `Spoke-Route-Table`.
2.  Chọn tab **Routes**.
3.  Click **Create route**.
4.  Cấu hình route:
    *   **CIDR:** `0.0.0.0/0`
    *   **Choose attachment:** Chọn attachment của **Hub VPC** (ví dụ: `Hub-VPC-TGW-Attachment`).
5.  Click **Create route**.

Hoặc bạn có thể dùng AWS CLI với lệnh tương tự như sau (thay thế các ID cho phù hợp):
```bash
aws ec2 create-transit-gateway-route \
  --destination-cidr-block 0.0.0.0/0 \
  --transit-gateway-route-table-id <ID-cua-Spoke-Route-Table> \
  --transit-gateway-attachment-id <ID-cua-Hub-VPC-Attachment>
```