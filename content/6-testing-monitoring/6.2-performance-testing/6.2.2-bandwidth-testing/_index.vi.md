---
title: "Kiểm thử Băng thông"
date: "`r Sys.Date()`"
menu : "main"
weight: 2
chapter : false
pre : " <b> 6.2.2 </b> "
---

### 2.2 Kiểm thử Băng thông

Phần này sử dụng `iperf3` để đo thông lượng mạng giữa các điểm khác nhau. `iperf3` hoạt động theo mô hình client-server.

**Lưu ý quan trọng:**
*   **Cài đặt `iperf3`:** Đảm bảo `iperf3` đã được cài đặt trên tất cả các instance tham gia kiểm thử (ví dụ: Bastion Host, instance Production, instance Development).
    # Trên Amazon Linux/CentOS/RHEL
```bash
sudo yum update -y
sudo yum install -y iperf3
```
![](/images/6.testing-monitoring/hinh-18.png)
# Trên Ubuntu/Debian
```bash
sudo apt update
sudo apt install -y iperf3
```
*   **Cấu hình Security Group:** Đảm bảo Security Group của instance đóng vai trò server (`iperf3 -s`) cho phép lưu lượng TCP trên cổng **5201** từ instance đóng vai trò client (`iperf3 -c`).
*   **Dừng `iperf3` server:** Sau khi kiểm thử, nhớ dừng các tiến trình `iperf3` server bằng `sudo killall iperf3` hoặc `ps aux | grep iperf3` sau đó `sudo kill <PID>`.

#### Các Kiểm thử và Hướng dẫn:

1.  **Khởi động `iperf3` Server trên instance đích:**
    *   **SSH vào instance đích** (ví dụ: instance Production `10.1.1.10`, instance Development `10.2.1.10`).
    *   Chạy lệnh: `iperf3 -s -D` (chạy server ở chế độ nền).

![](/images/6.testing-monitoring/hinh-19.png)
![](/images/6.testing-monitoring/hinh-20.png)
2.  **Kiểm thử băng thông từ Hub đến Production:**
    *   **Từ Bastion Host:**
        ```bash
        iperf3 -c <IP_instance_Production> -t 30 -P 4
        ```
![](/images/6.testing-monitoring/hinh-21.png)
    *   **Kết quả mong đợi:** Hiển thị thông lượng (ví dụ: Gbits/sec, Mbits/sec). Nếu kết nối không thành công (0.00 Bytes), kiểm tra lại `iperf3` server và Security Group.

3.  **Kiểm thử băng thông từ Production đến Development (nếu được phép):**
    *   **Khởi động `iperf3` Server trên instance Development.**
    *   **Từ Bastion Host, SSH vào instance Production và chạy lệnh client:**
        ```bash
        ssh -i ~/.ssh/Prod-Test-Instance-Key.pem ec2-user@<IP_instance_Production> "iperf3 -c <IP_instance_Development> -t 30"
        ```
![](/images/6.testing-monitoring/hinh-22.png)
![](/images/6.testing-monitoring/hinh-23.png)
    *   **Kết quả mong đợi:** Hiển thị thông lượng. Nếu có cách ly giữa Prod và Dev, lệnh này có thể thất bại (timeout/connection refused), đây là kết quả mong đợi cho bảo mật.

4.  **Kiểm thử băng thông đến internet (qua NAT Gateway):**
    *   **Từ Bastion Host:**
        ```bash
        iperf3 -c iperf.he.net -t 30
        ```
![](/images/6.testing-monitoring/hinh-24.png)
    *   **Kết quả mong đợi:** Hiển thị thông lượng ra Internet. (Lưu ý: `iperf.he.net` là một server công cộng).
