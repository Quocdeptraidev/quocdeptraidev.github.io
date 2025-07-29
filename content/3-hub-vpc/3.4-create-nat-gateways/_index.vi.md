---
title: "Tạo NAT Gateway"
date :  "`r Sys.Date()`" 
menu : "main"
weight : 4
chapter : false
pre : " <b> 3.4 </b> "
---

## Bước 4: Tạo NAT Gateways

### 4.1 NAT Gateway cho AZ-1a

1. Trong VPC Console, chọn **NAT Gateways**
2. Click **Create NAT Gateway**

![](/images/3.hub-vpc/hinh-22.png)
3. Cấu hình:

```
Name: Hub-NAT-Gateway-1a
Subnet: Hub-Public-Subnet-1a
Connectivity type: Public
Elastic IP allocation ID: Create new EIP
```
![](/images/3.hub-vpc/hinh-23.png)
4. Click **Create NAT Gateway**

### 4.2 NAT Gateway cho AZ-1b

```
Name: Hub-NAT-Gateway-1b
Subnet: Hub-Public-Subnet-1b
Connectivity type: Public
Elastic IP allocation ID: Create new EIP
```
![](/images/3.hub-vpc/hinh-24.png)
{{% notice info %}}
Chúng ta tạo 2 NAT Gateways để đảm bảo high availability.
{{% /notice %}}
