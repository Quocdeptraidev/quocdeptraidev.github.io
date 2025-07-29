---
title : "Tạo Spoke VPCs (Production & Development)"
date :  "2025-07-13" 
menu : "main"
weight : 1
chapter : false
pre : " <b> 4.1 </b> "
---

## Bước 1: Tạo Production VPC

### 1.1 Tạo Production VPC

1. Trong VPC Console, chọn **Your VPCs**
2. Click **Create VPC**

![](/images/4.spoke-vpcs/hinh-1.png)
3. Cấu hình:

```
Name tag: Production-VPC
IPv4 CIDR block: 10.1.0.0/16
IPv6 CIDR block: No IPv6 CIDR block
Tenancy: Default
```

![](/images/4.spoke-vpcs/hinh-2.png)

4. Click **Create VPC**

### 1.2 Enable DNS Settings

1. Select Production VPC

![](/images/4.spoke-vpcs/hinh-3.png)
2. Click **Actions** → **Edit VPC settings**
3. Enable:
   - **Enable DNS resolution**
   - **Enable DNS hostnames**

![](/images/4.spoke-vpcs/hinh-4.png)
4. Click **Save**

### 1.3 Tạo Production Subnets

#### Private Application Subnets

![](/images/4.spoke-vpcs/hinh-5.png)
```
Name: Prod-App-Subnet-1a
VPC: Production-VPC
Availability Zone: ap-southeast-1a
IPv4 CIDR block: 10.1.1.0/24
```

![](/images/4.spoke-vpcs/hinh-6.png)
![](/images/4.spoke-vpcs/hinh-7.png)
```
Name: Prod-App-Subnet-1b
VPC: Production-VPC
Availability Zone: ap-southeast-1b
IPv4 CIDR block: 10.1.2.0/24
```
![](/images/4.spoke-vpcs/hinh-8.png)
#### Private Database Subnets

```
Name: Prod-DB-Subnet-1a
VPC: Production-VPC
Availability Zone: ap-southeast-1a
IPv4 CIDR block: 10.1.11.0/24
```
![](/images/4.spoke-vpcs/hinh-9.png)
```
Name: Prod-DB-Subnet-1b
VPC: Production-VPC
Availability Zone: ap-southeast-1b
IPv4 CIDR block: 10.1.12.0/24
```
![](/images/4.spoke-vpcs/hinh-10.png)
#### Transit Gateway Subnets

```
Name: Prod-TGW-Subnet-1a
VPC: Production-VPC
Availability Zone: ap-southeast-1a
IPv4 CIDR block: 10.1.21.0/24
```
![](/images/4.spoke-vpcs/hinh-11.png)
```
Name: Prod-TGW-Subnet-1b
VPC: Production-VPC
Availability Zone: ap-southeast-1b
IPv4 CIDR block: 10.1.22.0/24
```
![](/images/4.spoke-vpcs/hinh-12.png)

## Bước 2: Tạo Development VPC

### 2.1 Tạo Development VPC

```
Name tag: Development-VPC
IPv4 CIDR block: 10.2.0.0/16
IPv6 CIDR block: No IPv6 CIDR block
Tenancy: Default
```
![](/images/4.spoke-vpcs/hinh-13.png)
### 2.2 Tạo Development Subnets

#### Private Application Subnets

```
Name: Dev-App-Subnet-1a
VPC: Development-VPC
Availability Zone: ap-southeast-1a
IPv4 CIDR block: 10.2.1.0/24
```
![](/images/4.spoke-vpcs/hinh-14.png)
![](/images/4.spoke-vpcs/hinh-15.png)
```
Name: Dev-App-Subnet-1b
VPC: Development-VPC
Availability Zone: ap-southeast-1b
IPv4 CIDR block: 10.2.2.0/24
```
![](/images/4.spoke-vpcs/hinh-16.png)
#### Private Database Subnets

```
Name: Dev-DB-Subnet-1a
VPC: Development-VPC
Availability Zone: ap-southeast-1a
IPv4 CIDR block: 10.2.11.0/24
```
![](/images/4.spoke-vpcs/hinh-17.png)
```
Name: Dev-DB-Subnet-1b
VPC: Development-VPC
Availability Zone: ap-southeast-1b
IPv4 CIDR block: 10.2.12.0/24
```
![](/images/4.spoke-vpcs/hinh-18.png)
#### Transit Gateway Subnets

```
Name: Dev-TGW-Subnet-1a
VPC: Development-VPC
Availability Zone: ap-southeast-1a
IPv4 CIDR block: 10.2.21.0/24
```
![](/images/4.spoke-vpcs/hinh-19.png)
```
Name: Dev-TGW-Subnet-1b
VPC: Development-VPC
Availability Zone: ap-southeast-1b
IPv4 CIDR block: 10.2.22.0/24
```
![](/images/4.spoke-vpcs/hinh-20.png)