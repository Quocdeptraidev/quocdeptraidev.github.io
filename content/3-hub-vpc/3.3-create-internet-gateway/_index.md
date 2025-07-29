---
title: "Create Internet Gateway"
date :  "`r Sys.Date()`" 
menu : "main"
weight : 3.3
chapter : false
pre : " <b> 3.3 </b> "
---

## Step 3: Create Internet Gateway

### 3.1 Create and Attach Internet Gateway

1. In the VPC Console, select **Internet Gateways**
![](/images/3.hub-vpc/hinh-17.png)
2. Click **Create Internet Gateway**
![](/images/3.hub-vpc/hinh-18.png)
3. Configure as follows:

```
Name tag: Hub-IGW
```
![](/images/3.hub-vpc/hinh-19.png)
4. Click **Create Internet Gateway**
5. Select the newly created IGW, click **Actions** → **Attach to VPC**
![](/images/3.hub-vpc/hinh-20.png)
6. Select **Hub-VPC** and click **Attach Internet Gateway**
![](/images/3.hub-vpc/hinh-21.png)
