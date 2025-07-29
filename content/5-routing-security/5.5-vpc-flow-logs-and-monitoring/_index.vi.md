---
title: "Nhật ký luồng VPC và Giám sát"
menu : "main"
weight: 5
chapter : false
pre : " <b> 5.5 </b> "
---

Bật nhật ký luồng (Flow Logs) là điều cần thiết để có được khả năng hiển thị chi tiết về lưu lượng mạng, giúp ích cho việc khắc phục sự cố và điều tra bảo mật.

### 5.1 Bật Nhật ký luồng Toàn diện

Chúng ta sẽ bật nhật ký luồng cho tất cả các VPC để ghi lại thông tin về lưu lượng IP đi đến và đi từ các giao diện mạng.

#### Nhật ký luồng VPC Hub
```bash
aws ec2 create-flow-logs \
    --resource-type VPC \
    --resource-ids vpc-hub-xxxxxxxxx \
    --traffic-type ALL \
    --log-destination-type cloud-watch-logs \
    --log-group-name /aws/vpc/hub/flowlogs \
    --deliver-logs-permission-arn arn:aws:iam::ACCOUNT:role/flowlogsRole
```
![](/images/5.routing-security/hinh-32.png)

#### Nhật ký luồng VPC Sản xuất
```bash
aws ec2 create-flow-logs \
    --resource-type VPC \
    --resource-ids vpc-prod-xxxxxxxxx \
    --traffic-type ALL \
    --log-destination-type cloud-watch-logs \
    --log-group-name /aws/vpc/production/flowlogs \
    --deliver-logs-permission-arn arn:aws:iam::ACCOUNT:role/flowlogsRole
```
![](/images/5.routing-security/hinh-33.png)

#### Nhật ký luồng VPC Phát triển
```bash
aws ec2 create-flow-logs \
    --resource-type VPC \
    --resource-ids vpc-dev-xxxxxxxxx \
    --traffic-type ALL \
    --log-destination-type cloud-watch-logs \
    --log-group-name /aws/vpc/development/flowlogs \
    --deliver-logs-permission-arn arn:aws:iam::ACCOUNT:role/flowlogsRole
```
![](/images/5.routing-security/hinh-35.png)

### 5.2 Nhật ký luồng Transit Gateway

Bật nhật ký luồng cho chính Transit Gateway để có cái nhìn tổng thể về tất cả lưu lượng đi qua mạng trung tâm.

```bash
aws ec2 create-transit-gateway-flow-logs \
    --transit-gateway-id tgw-xxxxxxxxx \
    --traffic-type ALL \
    --log-destination-type cloud-watch-logs \
    --log-group-name /aws/transitgateway/flowlogs
```