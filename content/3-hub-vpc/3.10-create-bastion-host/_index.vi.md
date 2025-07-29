---
title: "Tạo Bastion Host (Optional)"
date :  "`r Sys.Date()`" 
menu : "main"
weight : 10
chapter : false
pre : " <b> 3.10 </b> "
---

## Bước 10: Tạo Bastion Host (Optional)

### 10.1 Launch EC2 Instance

1. Trong EC2 Console, click **Launch Instance**

![](/images/3.hub-vpc/hinh-60.png)
2. Cấu hình:

```
Name: Hub-Bastion-Host
AMI: Amazon Linux 2023
Instance type: t3.micro
Key pair: Create new or use existing
Network settings:
  - VPC: Hub-VPC
  - Subnet: Hub-Public-Subnet-1a
  - Auto-assign public IP: Enable
  - Security group: Create new
```

![](/images/3.hub-vpc/hinh-61.png)
![](/images/3.hub-vpc/hinh-62.png)
![](/images/3.hub-vpc/hinh-63.png)
![](/images/3.hub-vpc/hinh-64.png)
### 10.2 Tạo và Gắn IAM Role cho Bastion Host

Để Bastion Host có thể truy cập các dịch vụ AWS (như S3, EC2) mà không cần cấu hình credential thủ công, bạn cần tạo và gắn một IAM Role cho nó.

1.  **Tạo IAM Role:**
    *   Mở AWS Console và điều hướng đến dịch vụ **IAM**.
    *   Trong thanh điều hướng bên trái, chọn **Roles**.
    *   Nhấp vào nút **Create role**.
    *   Chọn **AWS service** làm loại thực thể đáng tin cậy (trusted entity), sau đó chọn **EC2** làm trường hợp sử dụng (use case).
    *   Nhấp **Next**.
    *   Trong phần **Add permissions**, tìm kiếm và chọn các chính sách sau:
        *   `AmazonS3ReadOnlyAccess`
        *   `AmazonEC2ReadOnlyAccess`
        *   `AmazonSSMReadOnlyAccess`
        *   `CloudWatchLogsReadOnlyAccess`
        *   `AWSVPCReadOnlyAccess`
    *   Nhấp **Next**.
    *   Đặt tên cho Role, ví dụ: `BastionHostAccessRole`.
    *   Nhấp **Create role**.

![](/images/3.hub-vpc/hinh-71.png)

2.  **Gắn IAM Role vào Bastion Host:**
    *   Mở AWS Console và điều hướng đến dịch vụ **EC2**.
    *   Trong thanh điều hướng bên trái, chọn **Instances**.
    *   Tìm và chọn EC2 instance của bạn có tên là **`Hub-Bastion-Host`**.
    *   Nhấp vào **Actions** -> **Security** -> **Modify IAM role**.

![](/images/3.hub-vpc/hinh-72.png)
    *   Trong danh sách thả xuống **IAM role**, chọn **`BastionHostAccessRole`** mà bạn vừa tạo.
![](/images/3.hub-vpc/hinh-73.png)
    *   Nhấp **Update IAM role**.

### 10.3 Bastion Security Group

```
Name: Hub-Bastion-SG
Description: Security group for bastion host

Inbound Rules:
- Type: SSH (22)
  Source: Your IP address

Outbound Rules:
- Type: All Traffic
  Destination: 0.0.0.0/0
```
![](/images/3.hub-vpc/hinh-65.png)
