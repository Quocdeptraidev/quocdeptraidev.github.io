---
title: "Kiểm thử Nhóm Bảo mật"
date: "`r Sys.Date()`"
menu : "main"
weight: 1
chapter : false
pre : " <b> 6.3.1 </b> "
---

### 3.1 Kiểm thử Nhóm Bảo mật

#### Kiểm thử thủ công các cổng bị chặn

Để kiểm tra từng cổng một cách thủ công từ bên trong Production Instance (sau khi SSH từ Bastion Host), bạn có thể sử dụng các lệnh sau:

**Lưu ý:** Thay thế `10.1.1.10` bằng IP thực tế của instance bạn đang kiểm tra.

*   **Kiểm tra cổng RDP (3389):**
    ```bash
    nc -zv 10.1.1.10 3389
    ```
![](/images/6.testing-monitoring/hinh-27.png)
*   **Kiểm tra cổng SQL Server (1433):**
    ```bash
    nc -zv 10.1.1.10 1433
    ```
![](/images/6.testing-monitoring/hinh-28.png)
*   **Kiểm tra cổng PostgreSQL (5432):**
    ```bash
    nc -zv 10.1.1.10 5432
    ```
![](/images/6.testing-monitoring/hinh-29.png)
*   **Kiểm tra cổng Telnet (23):**
    ```bash
    nc -zv 10.1.1.10 23
    ```
![](/images/6.testing-monitoring/hinh-30.png)
