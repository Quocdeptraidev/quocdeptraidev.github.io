---
title: "Tạo một Transit Gateway"
date: "2025-07-12"
weight: 1
menu : "main"
chapter : false
pre : " <b> 2.1 </b> "
---

### 1.1. Truy Cập AWS Console

1.  Đăng nhập vào [AWS Management Console](https://aws.amazon.com/console/).
2.  Chọn Region **Asia Pacific (Singapore) `ap-southeast-1`**.

![Asia Pacific (Singapore)](/images/2.transit-gateway/hinh1.png)
3.  Trong thanh tìm kiếm, gõ **VPC** và chọn dịch vụ VPC.

![](/images/2.transit-gateway/hinh2.png)
4.  Trong thanh điều hướng bên trái, chọn **Transit Gateways**.

![](/images/2.transit-gateway/hinh3.png)
### 1.2. Cấu Hình và Tạo Transit Gateway

1.  Nhấp vào nút **Create Transit Gateway**.
![](/images/2.transit-gateway/hinh4.png)
2.  Điền các thông số cấu hình như sau:

| Tham Số | Giá Trị | Ghi Chú |
| :--- | :--- | :--- |
| **Name tag** | `Hub-TGW` | Tên để dễ dàng nhận diện Transit Gateway. |
| **Description** | `Transit Gateway for the central hub` | Mô tả mục đích của Transit Gateway. |
| **Amazon side ASN** | `64512` | ASN (Autonomous System Number) cho phía Amazon. Bạn có thể để mặc định. |
| **DNS support** | `Enable` | Cho phép phân giải DNS giữa các VPC. |
| **VPN ECMP support** | `Enable` | Hỗ trợ Equal-Cost Multi-Path routing cho kết nối VPN. |
| **Default route table association** | `Enable` | Tự động liên kết các attachment mới với bảng định tuyến mặc định. |
| **Default route table propagation** | `Enable` | Tự động quảng bá các routes từ attachment mới vào bảng định tuyến mặc định. |
| **Multicast support** | `Disable` | Vô hiệu hóa nếu bạn không có nhu cầu sử dụng multicast. |
| **Auto accept shared attachments** | `Enable` | Tự động chấp nhận các attachment được chia sẻ từ các tài khoản khác. |

![](/images/2.transit-gateway/hinh5.png)
![](/images/2.transit-gateway/hinh6.png)
3.  Nhấp vào **Create Transit Gateway**.
![](/images/2.transit-gateway/hinh7.png)
{{% notice info %}}
Quá trình tạo Transit Gateway có thể mất từ 10–15 phút để hoàn tất. Trạng thái sẽ chuyển từ `pending` sang `available`.
{{% /notice %}}
