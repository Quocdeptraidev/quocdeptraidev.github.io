---
title: "Kiểm thử Chuyển đổi dự phòng AZ"
date: "`r Sys.Date()`"
menu : "main"
weight: 4
chapter : false
pre : " <b> 6.4 </b> "
---

### 4.1 Kiểm thử Chuyển đổi dự phòng AZ

#### Giải thích:
Kiểm thử chuyển đổi dự phòng vùng sẵn sàng (AZ failover) là một phần quan trọng để đảm bảo tính sẵn sàng cao của kiến trúc của bạn. Bằng cách mô phỏng lỗi của một instance trong một AZ, bạn có thể xác minh rằng các ứng dụng của bạn có thể tự động chuyển sang một AZ khác mà không bị gián đoạn đáng kể. Điều này giúp xác nhận rằng các cơ chế như Auto Scaling Group, Load Balancer và các cấu hình đa AZ khác đang hoạt động đúng cách.

#### Mô phỏng Lỗi AZ

**Lưu ý quan trọng:**
*   Bạn cần có quyền AWS CLI được cấu hình để dừng và khởi động các instance EC2.
*   Thay thế `<Instance_ID_to_stop>` và `<Instance_ID_to_start>` bằng ID instance EC2 thực tế của bạn.
*   Thực hiện kiểm thử này trong môi trường không phải sản xuất hoặc trong thời gian bảo trì đã lên kế hoạch, vì nó sẽ làm gián đoạn instance.

#### Lấy địa chỉ IP riêng của Instance

Để thực hiện các kiểm thử chuyển đổi dự phòng, bạn cần biết địa chỉ IP riêng của các instance trong từng AZ. Việc lấy IP bằng AWS CLI đảm bảo tính chính xác và tự động hóa, đặc biệt hữu ích trong các môi trường lớn hoặc khi các instance được tạo/xóa động.

Bạn có thể sử dụng lệnh `aws ec2 describe-instances` để lấy địa chỉ IP riêng của các instance. Bạn sẽ cần biết ID của các instance (hoặc tên tag của chúng) để lọc kết quả.

**Cách lấy IP riêng của các instance:**

1.  **Lấy IP của Hub Instance (AZ1a):**
    *   **Nếu bạn biết Instance ID:**
        ```bash
        aws ec2 describe-instances --instance-ids <Hub_Instance_ID> --query "Reservations[].Instances[].PrivateIpAddress" --output text
        ```
        *(Thay `<Hub_Instance_ID>` bằng ID thực tế của Hub Instance của bạn)*

    *   **Nếu bạn biết tên Tag của Instance:**
        ```bash
        aws ec2 describe-instances --filters "Name=tag:Name,Values=HubInstanceName" --query "Reservations[].Instances[].PrivateIpAddress" --output text
        ```
        *(Thay `HubInstanceName` bằng tên Tag thực tế của Hub Instance của bạn)*

2.  **Lấy IP của Prod Instance (AZ1b):**
    *   **Nếu bạn biết Instance ID:**
        ```bash
        aws ec2 describe-instances --instance-ids <Prod_Instance_ID> --query "Reservations[].Instances[].PrivateIpAddress" --output text
        ```
    *   **Nếu bạn biết tên Tag của Instance:**
        ```bash
        aws ec2 describe-instances --filters "Name=tag:Name,Values=ProdInstanceName" --query "Reservations[].Instances[].PrivateIpAddress" --output text
        ```

3.  **Lấy IP của Dev Instance (AZ1b):**
    *   **Nếu bạn biết Instance ID:**
        ```bash
        aws ec2 describe-instances --instance-ids <Dev_Instance_ID> --query "Reservations[].Instances[].PrivateIpAddress" --output text
        ```
    *   **Nếu bạn biết tên Tag của Instance:**
        ```bash
        aws ec2 describe-instances --filters "Name=tag:Name,Values=DevInstanceName" --query "Reservations[].Instances[].PrivateIpAddress" --output text
        ```

Sau khi bạn đã có các địa chỉ IP riêng này, bạn có thể sử dụng chúng trong các lệnh `ping` ở Bước 1 của phần **Mô phỏng Lỗi AZ**.

**1. Kiểm thử kết nối đến cả hai AZ:**

Trước khi mô phỏng lỗi, hãy xác minh rằng bạn có thể kết nối đến các instance trong cả hai AZ.

*   **Kiểm thử kết nối đến AZ-1a (Hub Instance):**
    ```bash
    ping -c 3 <IP_Hub_Instance_AZ1a>
    ```
![](/images/6.testing-monitoring/hinh-35.png)
*   **Kiểm thử kết nối đến AZ-1b (Prod Instance):**
    ```bash
    ping -c 3 <IP_Prod_Instance_AZ1b>
    ```
![](/images/6.testing-monitoring/hinh-36.png)
*   **Kiểm thử kết nối đến AZ-1b (Dev Instance):**
    ```bash
    ping -c 3 <IP_Dev_Instance_AZ1b>
    ```
![](/images/6.testing-monitoring/hinh-37.png)
*   **Kết quả mong đợi:** Cả ba lệnh `ping` đều thành công (0% packet loss), cho thấy các instance đang hoạt động và có thể truy cập được.

**2. Mô phỏng lỗi instance trong một AZ:**

Dừng một instance trong một AZ để mô phỏng lỗi.

*   **Lệnh:**
    ```bash
    aws ec2 stop-instances --instance-ids <Instance_ID_to_stop>
    ```
![](/images/6.testing-monitoring/hinh-38.png)
    *(Thay `<Instance_ID_to_stop>` bằng ID của instance bạn muốn dừng. Ví dụ: `i-xxxxxxxxx`)*

*   **Kết quả mong đợi:** Lệnh sẽ trả về thông tin về instance đang được dừng.

**3. Chờ và kiểm thử chuyển đổi dự phòng:**

Chờ một khoảng thời gian để các cơ chế chuyển đổi dự phòng của AWS hoạt động, sau đó kiểm tra lại kết nối đến AZ còn lại.

*   **Lệnh:**
    ```bash
    sleep 30
    ping -c 3 <IP_instance_in_other_AZ>
    ```
![](/images/6.testing-monitoring/hinh-39.png)
![](/images/6.testing-monitoring/hinh-40.png)
    *(Thay `<IP_instance_in_other_AZ>` bằng IP của instance trong AZ còn lại mà bạn mong đợi lưu lượng sẽ chuyển sang.)*

*   **Kết quả mong đợi:** Lệnh `ping` đến instance trong AZ còn lại vẫn thành công, cho thấy lưu lượng đã được chuyển đổi dự phòng thành công.

**4. Khởi động lại instance (sau khi kiểm thử):**

Sau khi hoàn tất kiểm thử, hãy khởi động lại instance đã dừng.

*   **Lệnh:**
    ```bash
    aws ec2 start-instances --instance-ids <Instance_ID_to_start>
    ```
![](/images/6.testing-monitoring/hinh-41.png)
    *(Thay `<Instance_ID_to_start>` bằng ID của instance bạn đã dừng.)*

*   **Kết quả mong đợi:** Lệnh sẽ trả về thông tin về instance đang được khởi động.
