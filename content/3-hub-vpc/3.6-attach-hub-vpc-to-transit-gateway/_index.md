---
title: "Attach Hub VPC to Transit Gateway"
date :  "`r Sys.Date()`" 
menu : "main"
weight : 6
chapter : false
pre : " <b> 3.6 </b> "
---

## Step 6: Attach Hub VPC to Transit Gateway

### 6.1 Create Transit Gateway Attachment

1. In the VPC Console, select **Transit Gateway Attachments**
2. Click **Create Transit Gateway Attachment**

![](/images/3.hub-vpc/hinh-39.png)
3. Configure as follows:

```
Name tag: Hub-VPC-TGW-Attachment
Transit Gateway ID: Hub-TGW (from chapter 2)
Attachment type: VPC
VPC ID: Hub-VPC
Subnet IDs: 
  - Hub-TGW-Subnet-1a
  - Hub-TGW-Subnet-1b
```
![](/images/3.hub-vpc/hinh-40.png)
![](/images/3.hub-vpc/hinh-41.png)
4. Click **Create Transit Gateway Attachment**

### 6.2 Associate with Hub Route Table

1. Select **Transit Gateway Route Tables**
2. Select **Hub-Route-Table**
3. Click **Associations** tab
4. Click **Create association**

![](/images/3.hub-vpc/hinh-42.png)
5. Select Hub VPC attachment

![](/images/3.hub-vpc/hinh-43.png)
6. Click **Create association**
