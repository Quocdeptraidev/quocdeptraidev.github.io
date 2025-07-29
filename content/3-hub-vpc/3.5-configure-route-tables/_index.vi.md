---
title: "Cấu hình Route Tables"
date :  "`r Sys.Date()`" 
menu : "main"
weight : 5
chapter : false
pre : " <b> 3.5 </b> "
---


## Bước 5: Cấu hình Route Tables

### 5.1 Public Route Table

1. Chọn **Route Tables**
2. Click **Create Route Table**

![](/images/3.hub-vpc/hinh-25.png)
3. Cấu hình:

```
Name: Hub-Public-RT
VPC: Hub-VPC
```

![](/images/3.hub-vpc/hinh-26.png)
4. Sau khi tạo, click **Edit routes**

![](/images/3.hub-vpc/hinh-27.png)
5. Add route:

```
Destination: 0.0.0.0/0
Target: Hub-IGW
```
![](/images/3.hub-vpc/hinh-28.png)
6. Click **Save routes**
7. Click **Edit subnet associations**

![](/images/3.hub-vpc/hinh-29.png)
8. Associate với:
   - Hub-Public-Subnet-1a
   - Hub-Public-Subnet-1b

![](/images/3.hub-vpc/hinh-30.png)
### 5.2 Private Route Table AZ-1a

```
Name: Hub-Private-RT-1a
VPC: Hub-VPC

Routes:
- 0.0.0.0/0 → Hub-NAT-Gateway-1a

Subnet Associations:
- Hub-Private-Subnet-1a
```
![](/images/3.hub-vpc/hinh-31.png)
![](/images/3.hub-vpc/hinh-32.png)
![](/images/3.hub-vpc/hinh-33.png)
### 5.3 Private Route Table AZ-1b

```
Name: Hub-Private-RT-1b
VPC: Hub-VPC

Routes:
- 0.0.0.0/0 → Hub-NAT-Gateway-1b

Subnet Associations:
- Hub-Private-Subnet-1b
```
![](/images/3.hub-vpc/hinh-34.png)
![](/images/3.hub-vpc/hinh-35.png)
![](/images/3.hub-vpc/hinh-36.png)
### 5.4 Transit Gateway Route Table

```
Name: Hub-TGW-RT
VPC: Hub-VPC

Routes:
- 10.1.0.0/16 → Transit Gateway (sẽ add sau)
- 10.2.0.0/16 → Transit Gateway (sẽ add sau)

Subnet Associations:
- Hub-TGW-Subnet-1a
- Hub-TGW-Subnet-1b
```
![](/images/3.hub-vpc/hinh-37.png)
![](/images/3.hub-vpc/hinh-38.png)
