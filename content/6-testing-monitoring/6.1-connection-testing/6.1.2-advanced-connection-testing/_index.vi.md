---
title: "Kiểm thử Kết nối Nâng cao"
date: "`r Sys.Date()`"
menu : "main"
weight: 2
chapter : false
pre : " <b> 6.1.2 </b> "
---

### 1.2 Kiểm thử Kết nối Nâng cao

Phần này kiểm thử kết nối đến các cổng cụ thể, được thực hiện từ **Bastion Host của Hub VPC**.

**Lưu ý:**
*   Thay thế các địa chỉ IP placeholder (`10.1.1.10`, `10.2.1.10`, `10.1.11.10`) bằng **IP riêng thực tế** của các instance tương ứng.
*   Đảm bảo công cụ `nc` (netcat) đã được cài đặt trên Bastion Host.

#### Các Kiểm thử và Kết quả Mong đợi:

*   **Kiểm thử SSH access (cổng 22):**
    *   **Lệnh:** `nc -zv <IP_instance_Production> 22` và `nc -zv <IP_instance_Development> 22`

![](/images/6.testing-monitoring/hinh-6.png)
    *   **Kết quả mong đợi:** `THÀNH CÔNG`. Bastion Host được phép SSH vào các instance nội bộ.

*   **Kiểm thử HTTP/HTTPS (cổng 80/443):**
    *   **Lệnh:** `nc -zv <IP_instance_Production> 80` và `nc -zv <IP_instance_Production> 443`

![](/images/6.testing-monitoring/hinh-7.png)
    *   **Kết quả mong đợi:** Có thể `THÀNH CÔNG` hoặc `THẤT BẠI` (timeout/connection refused). Thường thì sẽ `THẤT BẠI` nếu Security Group của instance chỉ cho phép truy cập từ Load Balancer, đây là cấu hình bảo mật tốt.

*   **Kiểm thử các cổng cơ sở dữ liệu (cổng 3306/5432):**
    *   **Lệnh:** `nc -zv <IP_instance_DB_Production> 3306` và `nc -zv <IP_instance_DB_Production> 5432`

![](/images/6.testing-monitoring/hinh-8.png)
    *   **Kết quả mong đợi:** `THẤT BẠI` (timeout/connection refused). Các cổng cơ sở dữ liệu **nên bị chặn** truy cập trực tiếp từ Bastion Host để đảm bảo bảo mật, chúng chỉ nên được truy cập từ tầng ứng dụng.

*   **Kiểm thử VPC Endpoints (cổng 443):**
    *   **Lệnh:** `nc -zv s3.ap-southeast-1.amazonaws.com 443` và `nc -zv ec2.ap-southeast-1.amazonaws.com 443`

![](/images/6.testing-monitoring/hinh-9.png)
    *   **Kết quả mong đợi:** `THÀNH CÔNG`. Xác nhận VPC Endpoint hoạt động, cho phép truy cập dịch vụ AWS mà không qua internet.
