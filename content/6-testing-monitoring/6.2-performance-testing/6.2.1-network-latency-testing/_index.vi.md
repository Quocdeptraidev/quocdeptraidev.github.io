---
title: "Kiểm thử Độ trễ Mạng"
date: "`r Sys.Date()`"
menu : "main"
weight: 1
chapter : false
pre : " <b> 6.2.1 </b> "
---

### 2.1 Kiểm thử Độ trễ Mạng

Phần này đo lường độ trễ (latency) giữa Bastion Host của bạn và các điểm khác nhau trong mạng. Các kiểm thử này được thực hiện từ **Bastion Host của Hub VPC**.

**Lưu ý:**
*   Thay thế các địa chỉ IP placeholder (`10.1.1.10`, `10.1.2.10`, `10.0.1.10`) bằng **IP riêng thực tế** của các instance tương ứng.
*   `10.1.1.10` là IP của instance Production (cùng AZ).
*   `10.1.2.10` là IP của instance Production ở AZ khác (hoặc Development instance nếu không có multi-AZ Prod).
*   `10.0.1.10` là IP của một instance/tài nguyên trong Hub VPC.

#### Các Kiểm thử và Kết quả Mong đợi:

*   **Kiểm thử độ trễ trong cùng AZ (hoặc đến Production VPC):**
    *   **Lệnh:** `ping -c 10 <IP_instance_Production>`
![](/images/6.testing-monitoring/hinh-14.png)
    *   **Kết quả mong đợi:** Độ trễ rất thấp (dưới 1ms hoặc vài ms).

*   **Kiểm thử độ trễ giữa các AZ (trong Production VPC):**
    *   **Lệnh:** `ping -c 10 <IP_instance_Production_khác_AZ>`

![](/images/6.testing-monitoring/hinh-15.png)
    *   **Kết quả mong đợi:** Độ trễ thấp (vài ms), cao hơn một chút so với trong cùng AZ.

*   **Kiểm thử độ trễ đến Hub VPC:**
    *   **Lệnh:** `ping -c 10 <IP_instance_Hub>`

![](/images/6.testing-monitoring/hinh-16.png)
    *   **Kết quả mong đợi:** Độ trễ rất thấp (dưới 1ms hoặc vài ms).

*   **Kiểm thử độ trễ đến internet:**
    *   **Lệnh:** `ping -c 10 8.8.8.8`

![](/images/6.testing-monitoring/hinh-17.png)
    *   **Kết quả mong đợi:** Độ trễ cao hơn đáng kể (vài chục đến vài trăm ms). *Lưu ý: Độ trễ thực tế của bạn (~0.9ms) là cực kỳ thấp và cho thấy hiệu suất mạng xuất sắc.*
