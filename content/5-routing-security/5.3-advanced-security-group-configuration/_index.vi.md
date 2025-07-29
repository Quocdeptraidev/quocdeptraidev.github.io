---
title: "Cấu hình Nâng cao Nhóm Bảo mật"
menu : "main"
weight: 3
chapter : false
pre : " <b> 5.3 </b> "
---

Nhóm bảo mật (Security Groups) hoạt động như một tường lửa ảo cho các instance, kiểm soát lưu lượng vào và ra. Chúng ta sẽ cấu hình chúng theo nguyên tắc đặc quyền tối thiểu.

### 3.1 Quản lý Nhóm Bảo mật Tập trung

#### Nhóm Bảo mật Hub
Nhóm bảo mật này cho phép các dịch vụ chia sẻ trong Hub VPC giao tiếp với các Spoke.
```
Name: Hub-Shared-Services-SG
Description: Nhóm bảo mật cho các dịch vụ chia sẻ trong Hub

Inbound Rules:
- Type: HTTPS (443), Source: 10.1.0.0/16, 10.2.0.0/16
- Type: DNS (53), Source: 10.1.0.0/16, 10.2.0.0/16
- Type: NTP (123), Source: 10.1.0.0/16, 10.2.0.0/16

Outbound Rules:
- Type: All Traffic, Destination: 0.0.0.0/0
```
![](/images/5.routing-security/hinh-9.png)
![](/images/5.routing-security/hinh-10.png)

#### Nhóm Bảo mật Giao tiếp Liên-VPC
Cho phép giao tiếp có kiểm soát giữa các ứng dụng cụ thể trong các VPC khác nhau.
```
Name: Cross-VPC-Communication-SG
Description: Cho phép giao tiếp liên-VPC cụ thể

Inbound Rules:
- Type: Custom TCP (8080), Source: sg-xxxxxxxxx (SG ứng dụng cụ thể)
- Type: Custom TCP (5432), Source: sg-xxxxxxxxx (SG máy khách cơ sở dữ liệu)
```
![](/images/5.routing-security/hinh-11.png)
![](/images/5.routing-security/hinh-12.png)
![](/images/5.routing-security/hinh-13.png)

### 3.2 Phân đoạn vi mô (Micro-segmentation)

Chúng ta tạo các nhóm bảo mật riêng cho từng tầng của ứng dụng để giới hạn bề mặt tấn công.

#### Nhóm Bảo mật Tầng Web (Web Tier)
```
Name: Prod-Web-Tier-SG
Inbound: HTTP/HTTPS từ ALB, SSH từ Bastion
Outbound: Custom TCP (8080) đến App Tier
```
![](/images/5.routing-security/hinh-14.png)
![](/images/5.routing-security/hinh-15.png)
![](/images/5.routing-security/hinh-16.png)

#### Nhóm Bảo mật Tầng Ứng dụng (App Tier)
```
Name: Prod-App-Tier-SG
Inbound: Custom TCP (8080) từ Web Tier, SSH từ Bastion
Outbound: MySQL/Aurora (3306) đến DB Tier
```
![](/images/5.routing-security/hinh-17.png)
![](/images/5.routing-security/hinh-18.png)
![](/images/5.routing-security/hinh-19.png)

#### Nhóm Bảo mật Tầng Cơ sở dữ liệu (DB Tier)
```
Name: Prod-DB-Tier-SG
Inbound: MySQL/Aurora (3306) từ App Tier
Outbound: HTTPS (443) để cập nhật
```
![](/images/5.routing-security/hinh-20.png)
![](/images/5.routing-security/hinh-21.png)
![](/images/5.routing-security/hinh-22.png)