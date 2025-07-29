---
title: "Các Bước Tiếp Theo"
date: "2025-07-12"
weight: 7
menu : "main"
chapter : false
pre : " <b> 2.7 </b> "
---

Trong chương tiếp theo, chúng ta sẽ:
1.  Tạo một Hub VPC chứa các dịch vụ chia sẻ (shared services).
2.  Gắn (attach) Hub VPC vào Transit Gateway.
3.  Cấu hình NAT Gateway và VPC Endpoints trong Hub VPC.
4.  **Bật VPC Flow Logs** để giám sát lưu lượng mạng (chúng ta đã bỏ qua bước này ở chương này vì chưa có VPC).

{{% notice tip %}}
Hãy lưu lại ID của Transit Gateway – bạn sẽ cần nó cho các chương sau!
{{% /notice %}}

## Tài Liệu Tham Khảo

- [AWS Transit Gateway User Guide](https://docs.aws.amazon.com/vpc/latest/tgw/)
- [Transit Gateway Quotas](https://docs.aws.amazon.com/vpc/latest/tgw/transit-gateway-quotas.html)
