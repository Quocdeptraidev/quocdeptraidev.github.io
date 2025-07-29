---
title: "Tạo Internet Gateway"
date :  "`r Sys.Date()`" 
menu : "main"
weight : 3
chapter : false
pre : " <b> 3.3 </b> "
---

## Bước 3: Tạo Internet Gateway

### 3.1 Tạo và Attach Internet Gateway

1. Trong VPC Console, chọn **Internet Gateways**

![](/images/3.hub-vpc/hinh-17.png)
2. Click **Create Internet Gateway**

![](/images/3.hub-vpc/hinh-18.png)
3. Cấu hình:

```
Name tag: Hub-IGW
```
![](/images/3.hub-vpc/hinh-19.png)
4. Click **Create Internet Gateway**
5. Select IGW vừa tạo, click **Actions** → **Attach to VPC**

![](/images/3.hub-vpc/hinh-20.png)
6. Select **Hub-VPC** và click **Attach Internet Gateway**

![](/images/3.hub-vpc/hinh-21.png)
