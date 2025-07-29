---
title: "Security Groups"
date :  "`r Sys.Date()`" 
menu : "main"
weight : 9
chapter : false
pre : " <b> 3.9 </b> "
---

## Bước 9: Security Groups

### 9.1 Hub Default Security Group

1. Chọn **Security Groups**
2. Click **Create Security Group**

![](/images/3.hub-vpc/hinh-56.png)
3. Cấu hình:

```
Name: Hub-Default-SG
Description: Default security group for Hub VPC
VPC: Hub-VPC

Inbound Rules:
- Type: All Traffic
  Source: 10.0.0.0/16 (Private networks)

Outbound Rules:
- Type: All Traffic
  Destination: 0.0.0.0/0
```

![](/images/3.hub-vpc/hinh-57.png)
![](/images/3.hub-vpc/hinh-58.png)
![](/images/3.hub-vpc/hinh-59.png)
