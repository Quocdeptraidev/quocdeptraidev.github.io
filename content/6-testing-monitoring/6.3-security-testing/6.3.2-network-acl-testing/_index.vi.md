---
title: "Kiểm thử Network ACL"
date: "`r Sys.Date()`"
menu : "main"
weight: 2
chapter : false
pre : " <b> 6.3.2 </b> "
---

### 3.2 Kiểm thử Network ACL

Network ACLs (NACLs) hoạt động như một tường lửa không trạng thái ở cấp độ subnet, cung cấp một lớp bảo mật bổ sung cho VPC của bạn. Việc kiểm thử NACLs là cần thiết để đảm bảo rằng chúng đang thực thi các quy tắc lưu lượng vào và ra theo đúng thiết kế, đặc biệt là trong việc cách ly các môi trường khác nhau (ví dụ: Sản xuất và Phát triển) và kiểm soát luồng dữ liệu giữa các subnet. Điều này giúp ngăn chặn các truy cập trái phép và giới hạn phạm vi ảnh hưởng của các sự cố bảo mật.

#### Kiểm thử thủ công Network ACL

Để kiểm tra Network ACL, bạn sẽ chạy các lệnh sau từ **Bastion Host** của mình. Hãy thay thế các địa chỉ IP placeholder bằng IP thực tế của các instance của bạn.

**Lưu ý:** Đảm bảo file khóa SSH (`.pem` file) tương ứng đã được sao chép lên Bastion Host và có quyền phù hợp (`chmod 400`).

**1. Kiểm thử cách ly Sản xuất và Phát triển:**

*   **Lệnh:**
    ```bash
    ssh -i ~/.ssh/your-key.pem ec2-user@<IP_Production_Instance> "timeout 5 nc -zv <IP_Development_Instance> 22"
    ```
![](/images/6.testing-monitoring/hinh-31.png)
    *(Chạy lệnh này từ Bastion Host. Nó sẽ SSH vào Production Instance và từ đó cố gắng kết nối đến Development Instance qua cổng 22. Kết quả mong đợi là lệnh bị treo hoặc báo lỗi timeout, cho thấy kết nối bị chặn.)*

**2. Kiểm thử Hub có thể tiếp cận Sản xuất:**

*   **Lệnh:**
    ```bash
    timeout 5 nc -zv <IP_Production_Instance> 22
    ```
![](/images/6.testing-monitoring/hinh-32.png)
    *(Chạy lệnh này từ Bastion Host. Kết quả mong đợi là kết nối thành công.)*

**3. Kiểm thử Hub có thể tiếp cận Phát triển:**

*   **Lệnh:**
    ```bash
    timeout 5 nc -zv <IP_Development_Instance> 22
    ```
![](/images/6.testing-monitoring/hinh-33.png)
    *(Chạy lệnh này từ Bastion Host. Kết quả mong đợi là kết nối thành công.)*
