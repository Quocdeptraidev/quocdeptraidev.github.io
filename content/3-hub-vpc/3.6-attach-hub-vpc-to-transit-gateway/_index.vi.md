---
title: "Attach Hub VPC tới Transit Gateway"
date :  "`r Sys.Date()`" 
menu : "main"
weight : 6
chapter : false
pre : " <b> 3.6 </b> "
---



## Bước 6: Attach Hub VPC tới Transit Gateway

### 6.1 Tạo Transit Gateway Attachment

1. Trong VPC Console, chọn **Transit Gateway Attachments**
2. Click **Create Transit Gateway Attachment**

![](/images/3.hub-vpc/hinh-39.png)
3. Cấu hình:

```
Name tag: Hub-VPC-TGW-Attachment
Transit Gateway ID: Hub-TGW (từ chương 2)
Attachment type: VPC
VPC ID: Hub-VPC
Subnet IDs: 
  - Hub-TGW-Subnet-1a
  - Hub-TGW-Subnet-1b
```
![](/images/3.hub-vpc/hinh-40.png)
![](/images/3.hub-vpc/hinh-41.png)
4. Click **Create Transit Gateway Attachment**

### 6.2 Associate với Hub Route Table

1. Chọn **Transit Gateway Route Tables**
2. Select **Hub-Route-Table**
3. Click **Associations** tab
4. Click **Create association**

![](/images/3.hub-vpc/hinh-42.png)
5. Select Hub VPC attachment

![](/images/3.hub-vpc/hinh-43.png)
6. Click **Create association**
