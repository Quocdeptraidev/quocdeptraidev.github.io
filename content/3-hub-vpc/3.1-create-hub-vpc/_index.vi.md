---
title: "Tạo Hub VPC"
date :  "`r Sys.Date()`" 
menu : "main"
weight : 1
chapter : false
pre : " <b> 3.1 </b> "
---


## Bước 1: Tạo Hub VPC

### 1.1 Tạo VPC

1. Trong VPC Console, chọn **Your VPCs**

![](/images/3.hub-vpc/hinh-1.png)

2. Click **Create VPC**
3. Cấu hình:

```
Name tag: Hub-VPC
IPv4 CIDR block: 10.0.0.0/16
IPv6 CIDR block: No IPv6 CIDR block
Tenancy: Default
```

![](/images/3.hub-vpc/hinh-2.png)

4. Click **Create VPC**

### 1.2 Enable DNS Settings

1. Select Hub VPC vừa tạo
2. Click **Actions** → **Edit VPC settings**

![](/images/3.hub-vpc/hinh-3.png)

3. Enable:
   - **Enable DNS resolution**
   - **Enable DNS hostnames**

![](/images/3.hub-vpc/hinh-4.png)
4. Click **Save**
