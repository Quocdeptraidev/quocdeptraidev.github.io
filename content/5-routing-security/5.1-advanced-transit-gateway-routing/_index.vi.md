---
title: "Định tuyến Transit Gateway Nâng cao"
menu : "main"
weight: 1
chapter : false
pre : " <b> 5.1 </b> "
---


Trong phần này, chúng ta sẽ cấu hình các thành phần cốt lõi của việc định tuyến trong Transit Gateway để thiết lập nền tảng cho kiến trúc mạng của mình.

### 1.1 Tạo Bảng Định tuyến Chuyên dụng

Chúng ta bắt đầu bằng cách tạo các bảng định tuyến riêng biệt cho các mục đích khác nhau, cho phép kiểm soát lưu lượng một cách chi tiết.

#### Bảng Định tuyến Bảo mật
Bảng định tuyến này sẽ được được sử dụng để kiểm tra lưu lượng đi qua các thiết bị bảo mật.

```
Name: Security-Route-Table
Description: Bảng định tuyến để kiểm tra bảo mật
Transit Gateway: Enterprise-TGW
```
![](/images/5.routing-security/hinh-1.png)

#### Bảng Định tuyến Kiểm tra
Bảng định tuyến này dành cho việc kiểm tra và giám sát lưu lượng.
```
Name: Inspection-Route-Table
Description: Bảng định tuyến để kiểm tra lưu lượng
Transit Gateway: Enterprise-TGW
```
![](/images/5.routing-security/hinh-2.png)

### 1.2 Cấu hình Bảng Định tuyến Hub

Bảng định tuyến của Hub VPC sẽ điều hướng lưu lượng đến các Spoke VPC và ra internet.

1.  Chọn **Hub-Route-Table**
2.  Nhấp vào tab **Routes**
3.  Nhấp vào **Create route**
4.  Thêm các tuyến đường:

```
Routes:
- 10.1.0.0/16 → Production VPC Attachment
- 10.2.0.0/16 → Development VPC Attachment
- 0.0.0.0/0 → Hub VPC Attachment (để truy cập internet)
```

### 1.3 Cấu hình Bảng Định tuyến Spoke

Bảng định tuyến của các Spoke VPC sẽ định tuyến tất cả lưu lượng đến Hub VPC để xử lý tập trung.

1.  Chọn **Spoke-Route-Table**
2.  Thêm các tuyến đường:

```
Routes:
- 0.0.0.0/0 → Hub VPC Attachment (internet qua Hub NAT)
- 10.0.0.0/16 → Hub VPC Attachment (dịch vụ chia sẻ)
```

### 1.4 Triển khai Lan truyền Tuyến đường (Route Propagation)

Bật tính năng lan truyền tuyến đường để các Spoke VPC có thể tự động học các tuyến đường từ Hub.

```bash
# Bật lan truyền tuyến đường cho bảng định tuyến Hub
aws ec2 create-transit-gateway-route-table-propagation \
    --transit-gateway-attachment-id tgw-attach-xxxxxxxxx \
    --transit-gateway-route-table-id tgw-rtb-xxxxxxxxx
```
![](/images/5.routing-security/hinh-3.png)

