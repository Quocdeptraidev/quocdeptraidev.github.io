---
title : "Dọn dẹp tài nguyên"
date :  "`r Sys.Date()`" 
weight : 7
chapter : false
pre : " <b> 7. </b> "
---

Trong chương cuối này, chúng ta sẽ thực hiện cleanup toàn bộ resources đã tạo trong workshop để tránh phát sinh chi phí không mong muốn.

{{% notice warning %}}
**QUAN TRỌNG**: Thực hiện cleanup theo đúng thứ tự để tránh lỗi dependencies. Việc cleanup không thể hoàn tác!
{{% /notice %}}

## Tổng quan Cleanup Process

Cleanup process phải được thực hiện theo thứ tự sau:

1. **EC2 Instances và Load Balancers**
2. **VPC Endpoints**
3. **Transit Gateway Attachments**
4. **Transit Gateway Route Tables**
5. **Transit Gateway**
6. **NAT Gateways và Elastic IPs**
7. **Internet Gateways**
8. **Route Tables**
9. **Subnets**
10. **Security Groups**
11. **VPCs**
12. **CloudWatch Resources**


