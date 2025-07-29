---
title: "Tạo VPC Endpoints"
date :  "`r Sys.Date()`" 
menu : "main"
weight : 8
chapter : false
pre : " <b> 3.8 </b> "
---


## Bước 8: Tạo VPC Endpoints

### 8.1 S3 Gateway Endpoint

1. Trong VPC Console, chọn **Endpoints**
2. Click **Create Endpoint**

![](/images/3.hub-vpc/hinh-44.png)
3. Cấu hình:

```
Name tag: Hub-S3-Endpoint
Service category: AWS services
Service Name: com.amazonaws.ap-southeast-1.s3 (Type: Gateway)
VPC: Hub-VPC
Route tables: Select the private route tables (Hub-Private-RT-1a, Hub-Private-RT-1b)
Policy: Full access
```
![](/images/3.hub-vpc/hinh-45.png)
![](/images/3.hub-vpc/hinh-46.png)
![](/images/3.hub-vpc/hinh-47.png)
4. Click **Create Endpoint**

### 8.2.1 Tạo Security Group cho VPC Endpoints

Trước khi tạo các Interface Endpoint, bạn cần tạo một Security Group để kiểm soát lưu lượng truy cập vào chúng.

1.  Trong VPC Console, chọn **Security Groups**.
2.  Nhấp **Create security group**.
3.  Cấu hình:
    | Tham Số | Giá Trị |
    | :--- | :--- |
    | **Security group name** | `Hub-VPCEndpoint-SG` |
    | **Description** | `Security group for VPC Endpoints in Hub VPC` |
    | **VPC** | `Hub-VPC` |
    | **Inbound rules** | Type: `HTTPS` (Port 443), Source: `10.0.0.0/16` (CIDR của Hub-VPC) |
    | **Outbound rules** | Type: `All Traffic`, Destination: `0.0.0.0/0` |

![](/images/3.hub-vpc/hinh-48.png)
![](/images/3.hub-vpc/hinh-49.png)

4.  Nhấp **Create security group**.

### 8.2 EC2 Interface Endpoint

| Tham Số | Giá Trị |
| :--- | :--- |
| **Name tag** | `Hub-EC2-Endpoint` |
| **Service category** | `AWS services` |
| **Service Name** | `com.amazonaws.ap-southeast-1.ec2` (Type: `Interface`) |
| **VPC** | `Hub-VPC` |
| **Subnets** | `Hub-Private-Subnet-1a`, `Hub-Private-Subnet-1b` |
| **Security groups** | `Hub-VPCEndpoint-SG` |
| **Policy** | `Full access` |

{{% notice info%}}
**Lưu ý:** Nếu có tùy chọn **Enable Private DNS Name**, hãy **bỏ chọn** tùy chọn này để tránh xung đột DNS khi truy cập dịch vụ từ mạng nội bộ.
{{% /notice %}}

![](/images/3.hub-vpc/hinh-50.png)
![](/images/3.hub-vpc/hinh-51.png)
![](/images/3.hub-vpc/hinh-52.png)
![](/images/3.hub-vpc/hinh-53.png)
### 8.3 SSM Interface Endpoints

Tạo các endpoints cho Systems Manager:

```
Endpoints cần tạo:
- com.amazonaws.ap-southeast-1.ssm
- com.amazonaws.ap-southeast-1.ssmmessages
- com.amazonaws.ap-southeast-1.ec2messages
```
![](/images/3.hub-vpc/hinh-54.png)
![](/images/3.hub-vpc/hinh-55.png)
