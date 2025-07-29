---
title: "Kiểm thử Phân giải DNS"
date: "`r Sys.Date()`"
menu : "main"
weight: 3
chapter : false
pre : " <b> 6.1.3 </b> "
---

### 1.3 Kiểm thử Phân giải DNS

Phần này xác minh khả năng phân giải tên miền của các instance, cả nội bộ và bên ngoài. Các kiểm thử này được thực hiện từ **Bastion Host của Hub VPC**.

**Lưu ý:**
*   Đảm bảo công cụ `nslookup` đã được cài đặt trên Bastion Host (ví dụ: `sudo yum install bind-utils -y` hoặc `sudo apt install dnsutils -y`).
*   Thay thế các địa chỉ IP và tên DNS nội bộ placeholder bằng giá trị thực tế của bạn.

#### Các Kiểm thử và Kết quả Mong đợi:

*   **Kiểm thử phân giải DNS nội bộ:**
    *   **Lệnh:** `nslookup ip-<IP_instance_Production_hoặc_Development_có_dấu_gạch_ngang>.ap-southeast-1.compute.internal`

![](/images/6.testing-monitoring/hinh-10.png)
    *   **Kết quả mong đợi:** `THÀNH CÔNG` (trả về địa chỉ IP tương ứng). Xác nhận DNS Resolver của VPC có thể phân giải tên DNS nội bộ.

*   **Kiểm thử phân giải DNS bên ngoài:**
    *   **Lệnh:** `nslookup google.com`

![](/images/6.testing-monitoring/hinh-11.png)
    *   **Kết quả mong đợi:** `THÀNH CÔNG` (trả về địa chỉ IP công cộng của google.com). Xác nhận có thể phân giải tên miền bên ngoài Internet.

*   **Kiểm thử DNS VPC Endpoint:**
    *   **Lệnh:** `nslookup s3.ap-southeast-1.amazonaws.com` (hoặc các dịch vụ khác)

![](/images/6.testing-monitoring/hinh-12.png)
    *   **Kết quả mong đợi:** `THÀNH CÔNG` (trả về địa chỉ IP riêng của VPC Endpoint trong VPC của bạn). Xác nhận VPC Endpoint hoạt động, cho phép truy cập dịch vụ AWS mà không qua internet.

*   **Kiểm thử phân giải DNS ngược:**
    *   **Lệnh:** `nslookup <IP_instance_Production_hoặc_Development>`

![](/images/6.testing-monitoring/hinh-13.png)
    *   **Kết quả mong đợi:** `THÀNH CÔNG` (trả về tên DNS nội bộ của instance tương ứng). Xác nhận DNS Resolver có thể phân giải địa chỉ IP thành tên DNS.
