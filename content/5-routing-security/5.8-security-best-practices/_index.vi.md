---
title: "Triển khai các Thực hành Tốt nhất về Bảo mật"
menu : "main"
weight: 8
chapter : false
pre : " <b> 5.8 </b> "
---

Luôn tuân thủ các thực hành tốt nhất (best practices) là rất quan trọng để duy trì một môi trường an toàn.

### 8.1 Nguyên tắc Đặc quyền Tối thiểu (Principle of Least Privilege)

Nguyên tắc này yêu cầu chỉ cấp các quyền tối thiểu cần thiết để thực hiện một chức năng. Chúng ta áp dụng điều này bằng cách thường xuyên xem xét và thắt chặt các quy tắc trong Nhóm Bảo mật.

#### Xem xét và Thắt chặt Nhóm Bảo mật

Sử dụng AWS CLI để kiểm tra các quy tắc nhóm bảo mật, đặc biệt là các quy tắc cho phép truy cập từ mọi nơi (`0.0.0.0/0`).

```bash
# Script để kiểm tra các quy tắc nhóm bảo mật quá rộng
aws ec2 describe-security-groups \
    --query 'SecurityGroups[?IpPermissions[?IpRanges[?CidrIp==`0.0.0.0/0`]]].[GroupId,GroupName]' \
    --output table
```
![](/images/5.routing-security/hinh-67.png)
![](/images/5.routing-security/hinh-68.png)
