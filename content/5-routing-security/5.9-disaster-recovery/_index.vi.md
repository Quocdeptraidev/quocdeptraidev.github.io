---
title: "Phục hồi sau Thảm họa và Tính liên tục trong Kinh doanh"
menu : "main"
weight: 9
chapter : false
pre : " <b> 5.9 </b> "
---

Lập kế hoạch cho khả năng phục hồi là một phần không thể thiếu của một kiến trúc vững chắc.

### 9.1 Xác minh Triển khai Đa-AZ (Multi-AZ)

Đảm bảo rằng các tài nguyên quan trọng được triển khai trên nhiều Vùng sẵn sàng (Availability Zones) để tăng tính sẵn sàng cao.

```bash
# Xác minh các subnet được triển khai trên nhiều AZ
aws ec2 describe-subnets \
    --filters "Name=vpc-id,Values=vpc-xxxxxxxxx" \
    --query 'Subnets[*].[SubnetId,AvailabilityZone,CidrBlock]' \
    --output table
```
![](/images/5.routing-security/hinh-69.png)
![](/images/5.routing-security/hinh-70.png)
![](/images/5.routing-security/hinh-71.png)

### 9.2 Quy trình Sao lưu và Phục hồi

Thường xuyên sao lưu cấu hình mạng của bạn để có thể nhanh chóng phục hồi trong trường hợp xảy ra sự cố.

#### Sao lưu Cấu hình Transit Gateway

Xuất cấu hình Transit Gateway và các bảng định tuyến của nó ra các tệp JSON.

```bash
# Xuất cấu hình Transit Gateway
aws ec2 describe-transit-gateways \
    --transit-gateway-ids tgw-xxxxxxxxx > tgw-backup.json

# Xuất các bảng định tuyến của Transit Gateway
aws ec2 describe-transit-gateway-route-tables \
    --filters "Name=transit-gateway-id,Values=tgw-xxxxxxxxx" > tgw-routes-backup.json
```
![](/images/5.routing-security/hinh-72.png)
