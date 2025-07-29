---
title: "Tổng quan Hub VPC"
date :  "`r Sys.Date()`" 
weight : 3
chapter : false
pre : " <b> 3. </b> "
---
Trong chương này, chúng ta sẽ tạo Hub VPC - trung tâm của kiến trúc hub-and-spoke, nơi chứa các shared services như NAT Gateway, DNS, và VPC Endpoints.

Tổng quan Hub VPC
Hub VPC đóng vai trò là trung tâm cung cấp shared services cho toàn bộ kiến trúc. Nó bao gồm:
- Internet connectivity qua Internet Gateway
- Outbound internet access qua NAT Gateway cho spoke VPCs
- VPC Endpoints cho AWS services
- DNS resolution services
- Security services như bastion hosts

**Các phần trong chương này:**

- [Bước 1: Tạo Hub VPC](./3.1-create-hub-vpc)
- [Bước 2: Tạo Subnets](./3.2-create-subnets)
- [Bước 3: Tạo Internet Gateway](./3.3-create-internet-gateway)
- [Bước 4: Tạo NAT Gateways](./3.4-create-nat-gateways)
- [Bước 5: Cấu hình Route Tables](./3.5-configure-route-tables)
- [Bước 6: Attach Hub VPC tới Transit Gateway](./3.6-attach-hub-vpc-to-transit-gateway)
- [Bước 7: Giám Sát và Ghi Log (VPC Flow Logs)](./3.7-monitoring-and-logging)
- [Bước 8: Tạo VPC Endpoints](./3.8-create-vpc-endpoints)
- [Bước 9: Security Groups](./3.9-security-groups)
- [Bước 10: Tạo Bastion Host (Optional)](./3.10-create-bastion-host)
- [Bước 11: Testing Hub VPC](./3.11-testing-hub-vpc)
- [Tối Ưu Hóa Chi Phí](./3.12-cost-optimization)
- [Xử Lý Sự Cố (Troubleshooting)](./3.13-troubleshooting)
- [Next Steps](./3.14-next-steps)
- [Tài liệu tham khảo](./3.15-references)
