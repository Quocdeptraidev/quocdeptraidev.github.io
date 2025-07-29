---
title: "Create NAT Gateways"
date :  "`r Sys.Date()`" 
menu : "main"
weight : 3.4
chapter : false
pre : " <b> 3.4 </b> "
---


## Step 4: Create NAT Gateways

### 4.1 NAT Gateway for AZ-1a

1. In the VPC Console, select **NAT Gateways**
2. Click **Create NAT Gateway**
![](/images/3.hub-vpc/hinh-22.png)
3. Configure as follows:

```
Name: Hub-NAT-Gateway-1a
Subnet: Hub-Public-Subnet-1a
Connectivity type: Public
Elastic IP allocation ID: Create new EIP
```
![](/images/3.hub-vpc/hinh-23.png)
4. Click **Create NAT Gateway**

### 4.2 NAT Gateway for AZ-1b

```
Name: Hub-NAT-Gateway-1b
Subnet: Hub-Public-Subnet-1b
Connectivity type: Public
Elastic IP allocation ID: Create new EIP
```
![](/images/3.hub-vpc/hinh-24.png)
{{% notice info %}}
We create 2 NAT Gateways to ensure high availability.
{{% /notice %}}
