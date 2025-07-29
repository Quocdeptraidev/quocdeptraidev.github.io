---
title: "Create Subnet"
date :  "`r Sys.Date()`" 
menu : "main"
weight : 3.2
chapter : false
pre : " <b> 3.2 </b> "
---


## Step 2: Create Subnets

### 2.1 Public Subnets (for NAT Gateway and Internet Gateway)

- #### Public Subnet AZ-1a
```
Name: Hub-Public-Subnet-1a
VPC: Hub-VPC
Availability Zone: ap-southeast-1a
IPv4 CIDR block: 10.0.1.0/24
```
![](/images/3.hub-vpc/hinh-5.png)
![](/images/3.hub-vpc/hinh-6.png)
- #### Public Subnet AZ-1b
```
Name: Hub-Public-Subnet-1b
VPC: Hub-VPC
Availability Zone: ap-southeast-1b
IPv4 CIDR block: 10.0.2.0/24
```
![](/images/3.hub-vpc/hinh-7.png)
![](/images/3.hub-vpc/hinh-8.png)
### 2.2 Private Subnets (for shared services)

- #### Private Subnet AZ-1a
```
Name: Hub-Private-Subnet-1a
VPC: Hub-VPC
Availability Zone: ap-southeast-1a
IPv4 CIDR block: 10.0.11.0/24
```
![](/images/3.hub-vpc/hinh-9.png)
![](/images/3.hub-vpc/hinh-10.png)
- #### Private Subnet AZ-1b
```
Name: Hub-Private-Subnet-1b
VPC: Hub-VPC
Availability Zone: ap-southeast-1b
IPv4 CIDR block: 10.0.12.0/24
```
![](/images/3.hub-vpc/hinh-11.png)
![](/images/3.hub-vpc/hinh-12.png)
### 2.3 Transit Gateway Subnets

- #### TGW Subnet AZ-1a
```
Name: Hub-TGW-Subnet-1a
VPC: Hub-VPC
Availability Zone: ap-southeast-1a
IPv4 CIDR block: 10.0.21.0/24
```
![](/images/3.hub-vpc/hinh-13.png)
![](/images/3.hub-vpc/hinh-14.png)
- #### TGW Subnet AZ-1b
```
Name: Hub-TGW-Subnet-1b
VPC: Hub-VPC
Availability Zone: ap-southeast-1b
IPv4 CIDR block: 10.0.22.0/24
```
![](/images/3.hub-vpc/hinh-15.png)
![](/images/3.hub-vpc/hinh-16.png)
