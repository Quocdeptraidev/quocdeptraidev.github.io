---
title: "Triển khai Network ACL"
menu : "main"
weight: 4
chapter : false
pre : " <b> 5.4 </b> "
---

Network ACLs (NACLs) là một lớp bảo mật tùy chọn cho VPC của bạn, hoạt động như một tường lửa cho các subnet, kiểm soát lưu lượng vào và ra khỏi một hoặc nhiều subnet.

### 4.1 Network ACL Sản xuất
Cấu hình chặt chẽ để chỉ cho phép lưu lượng cần thiết và từ chối mọi giao tiếp từ môi trường Phát triển.
```
Name: Production-NACL
VPC: Production-VPC

Inbound Rules:
Rule #  | Type        | Protocol | Port Range | Source      | Allow/Deny
100     | HTTP        | TCP      | 80         | 0.0.0.0/0   | ALLOW
110     | HTTPS       | TCP      | 443        | 0.0.0.0/0   | ALLOW
120     | SSH         | TCP      | 22         | 10.0.0.0/16 | ALLOW
130     | MySQL       | TCP      | 3306       | 10.1.0.0/16 | ALLOW
140     | Custom TCP  | TCP      | 8080       | 10.1.0.0/16 | ALLOW
150     | Custom TCP  | TCP      | 1024-65535 | 0.0.0.0/0   | ALLOW
200     | All Traffic | All      | All        | 10.2.0.0/16 | DENY

Outbound Rules:
Rule #  | Type        | Protocol | Port Range | Destination | Allow/Deny
100     | All Traffic | All      | All        | 0.0.0.0/0   | ALLOW
```
![](/images/5.routing-security/hinh-23.png)
![](/images/5.routing-security/hinh-24.png)

### 4.2 Network ACL Phát triển
Cho phép giao tiếp nội bộ và từ Hub, nhưng từ chối mọi nỗ lực kết nối từ môi trường Sản xuất.
```
Name: Development-NACL
VPC: Development-VPC

Inbound Rules:
Rule #  | Type        | Protocol | Port Range | Source      | Allow/Deny
100     | All Traffic | All      | All        | 10.0.0.0/16 | ALLOW
110     | All Traffic | All      | All        | 10.2.0.0/16 | ALLOW
120     | Ephemeral   | TCP      | 1024-65535 | 0.0.0.0/0   | ALLOW
200     | All Traffic | All      | All        | 10.1.0.0/16 | DENY

Outbound Rules:
Rule #  | Type        | Protocol | Port Range | Destination | Allow/Deny
100     | All Traffic | All      | All        | 0.0.0.0/0   | ALLOW
```
![](/images/5.routing-security/hinh-25.png)
![](/images/5.routing-security/hinh-26.png)
![](/images/5.routing-security/hinh-27.png)

### 4.3 Network ACL Hub
Cho phép lưu lượng từ các Spoke và internet, nhưng có quy tắc cụ thể cho việc truy cập quản trị (SSH) từ một địa chỉ IP công cộng được chỉ định.
```
Name: Hub-NACL
VPC: Hub-VPC

Inbound Rules:
Rule #  | Type        | Protocol | Port Range | Source           | Allow/Deny
100     | All Traffic | All      | All        | 10.1.0.0/16 | ALLOW
110     | All Traffic | All      | All        | 10.2.0.0/16 | ALLOW
120     | HTTP        | TCP      | 80         | 0.0.0.0/0   | ALLOW
130     | HTTPS       | TCP      | 443        | 0.0.0.0/0   | ALLOW
140     | SSH         | TCP      | 22         | 66.249.66.161/32 | ALLOW
150     | Custom TCP  | TCP      | 1024-65535 | 0.0.0.0/0   | ALLOW

Outbound Rules:
Rule #  | Type        | Protocol | Port Range | Destination | Allow/Deny
100     | All Traffic | All      | All        | 0.0.0.0/0   | ALLOW
```
![](/images/5.routing-security/hinh-28.png)
![](/images/5.routing-security/hinh-29.png)
![](/images/5.routing-security/hinh-30.png)