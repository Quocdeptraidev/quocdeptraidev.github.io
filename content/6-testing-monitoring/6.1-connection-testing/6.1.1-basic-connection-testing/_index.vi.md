---
title: "Kiểm thử Kết nối Cơ bản"
date: "`r Sys.Date()`"
menu : "main"
weight: 1
chapter : false
pre : " <b> 6.1.1 </b> "
---

### 1.1 Kiểm thử Kết nối Cơ bản

Các kiểm thử này được thực hiện từ **Bastion Host của Hub VPC** để xác minh kết nối mạng cơ bản giữa các VPC và Internet. 

**Lưu ý:**
*   Thay thế các địa chỉ IP placeholder (`10.1.1.10`, `10.2.1.10`, v.v.) bằng **IP riêng thực tế** của các instance trong VPC Sản xuất và Phát triển của bạn.
*   Đảm bảo các công cụ như `ping`, `ssh`, `curl` và `nc` (netcat) đã được cài đặt trên Bastion Host và các instance đích nếu cần.
*   Nếu sử dụng `ssh` để chạy lệnh trên instance đích, hãy đảm bảo khóa SSH (`.pem` file) tương ứng đã được sao chép lên Bastion Host và có quyền phù hợp (`chmod 400`).

#### Các Kiểm thử và Kết quả Mong đợi:

1.  **Kiểm thử Hub đến Sản xuất/Phát triển (sử dụng `ping`):**
    *   **Lệnh:** `ping -c 3 <IP_instance_Production>` và `ping -c 3 <IP_instance_Development>`
![](/images/6.testing-monitoring/hinh-1.png)
![](/images/6.testing-monitoring/hinh-2.png)
    *   **Kết quả mong đợi:** `THÀNH CÔNG` (0% packet loss). Điều này xác nhận kết nối cơ bản giữa Hub và các VPC spoke.

2.  **Kiểm thử Cách ly Sản xuất đến Phát triển (sử dụng `ssh` và `ping`):**
    *   **Lệnh:** `ssh -o ConnectTimeout=5 ec2-user@<IP_instance_Production> "ping -c 1 <IP_instance_Development>"`
    ![](/images/6.testing-monitoring/hinh-3.png)
    *   **Kết quả mong đợi:** `THÀNH CÔNG` (100% packet loss cho `ping` bên trong). Điều này xác nhận rằng lưu lượng giữa Production và Development bị chặn, đảm bảo cách ly như thiết kế.

3.  **Kiểm thử Kết nối Internet từ các VPC Spoke (sử dụng `ssh` và `curl`):**
    *   **Lệnh:** `ssh -i <Path_to_your_SSH_Key.pem> ec2-user@<IP_Production_Instance_AZ1a> "curl -s --connect-timeout 5 http://google.com"` và tương tự cho Development.
    ![](/images/6.testing-monitoring/hinh-4.png)
    ![](/images/6.testing-monitoring/hinh-5.png)
    *   **Kết quả mong đợi:** `THÀNH CÔNG` (trả về mã HTML ngắn). Điều này xác nhận rằng các instance trong VPC spoke có thể truy cập Internet thông qua NAT Gateway của Hub VPC.
