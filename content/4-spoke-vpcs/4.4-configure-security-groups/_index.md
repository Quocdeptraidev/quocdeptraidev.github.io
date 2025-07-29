---
title : "Configure Security Groups"
date :  "2025-07-13" 
menu : "main"
weight : 4
chapter : false
pre : " <b> 4.4 </b> "
---

## Step 6: Configure Security Groups

### 6.1 Production Security Groups

#### Load Balancer Security Group (Prod-ALB-SG)

Before configuring the Application Security Group, you need to create the Load Balancer Security Group.

1.  In the VPC Console, select **Security Groups**.
2.  Click **Create security group**.
3.  Configure:
    | Parameter | Value |
    | :--- | :--- |
    | **Name** | `Prod-ALB-SG` |
    | **Description** | `Security group for production load balancer` |
    | **VPC** | `Production-VPC` |
    | **Inbound Rules** | Type: `HTTP` (80), Source: `0.0.0.0/0` \ Type: `HTTPS` (443), Source: `0.0.0.0/0` |
    | **Outbound Rules** | Type: `All Traffic`, Destination: `0.0.0.0/0` |

![](/images/4.spoke-vpcs/hinh-44.png)
![](/images/4.spoke-vpcs/hinh-45.png)
![](/images/4.spoke-vpcs/hinh-46.png)

4.  Click **Create security group**.

#### Application Security Group (Prod-App-SG)

```
Name: Prod-App-SG
Description: Security group for production applications
VPC: Production-VPC

Inbound Rules:
- Type: HTTP (80)
  Source: Prod-ALB-SG
- Type: HTTPS (443)
  Source: Prod-ALB-SG
- Type: SSH (22)
  Source: 10.0.0.0/16 (Hub VPC for bastion)
- Type: All ICMP - IPv4
  Source: 10.0.0.0/16 (Hub VPC for ping testing)

Outbound Rules:
- Type: All Traffic
  Destination: 0.0.0.0/0
```
![](/images/4.spoke-vpcs/hinh-39.png)
![](/images/4.spoke-vpcs/hinh-40.png)
#### Database Security Group (Prod-DB-SG)

```
Name: Prod-DB-SG
Description: Security group for production databases
VPC: Production-VPC

Inbound Rules:
- Type: MySQL/Aurora (3306)
  Source: Prod-App-SG
- Type: PostgreSQL (5432)
  Source: Prod-App-SG

Outbound Rules:
- Type: All Traffic
  Destination: 0.0.0.0/0
```
![](/images/4.spoke-vpcs/hinh-41.png)
![](/images/4.spoke-vpcs/hinh-42.png)
![](/images/4.spoke-vpcs/hinh-43.png)
### 6.2 Development Security Groups

#### Load Balancer Security Group (Dev-ALB-SG)

Before configuring the Application Security Group, you need to create the Load Balancer Security Group.

1.  In the VPC Console, select **Security Groups**.
2.  Click **Create security group**.
3.  Configure:
    | Parameter | Value |
    | :--- | :--- |
    | **Name** | `Dev-ALB-SG` |
    | **Description** | `Security group for development load balancer` |
    | **VPC** | `Development-VPC` |
    | **Inbound Rules** | Type: `HTTP` (80), Source: `0.0.0.0/0` \ Type: `HTTPS` (443), Source: `0.0.0.0/0` |
    | **Outbound Rules** | Type: `All Traffic`, Destination: `0.0.0.0/0` |
  

4.  Click **Create security group**.

#### Application Security Group (Dev-App-SG)

```
Name: Dev-App-SG
Description: Security group for development applications
VPC: Development-VPC

Inbound Rules:
- Type: All Traffic
  Source: 10.2.0.0/16 (within Dev VPC)
- Type: SSH (22)
  Source: 10.0.0.0/16 (Hub VPC for bastion)
- Type: All ICMP - IPv4
  Source: 10.0.0.0/16 (Hub VPC for ping testing)

Outbound Rules:
- Type: All Traffic
  Destination: 0.0.0.0/0
```
![](/images/4.spoke-vpcs/hinh-47.png)
![](/images/4.spoke-vpcs/hinh-48.png)
![](/images/4.spoke-vpcs/hinh-49.png)
#### Database Security Group (Dev-DB-SG)

```
Name: Dev-DB-SG
Description: Security group for development databases
VPC: Development-VPC

Inbound Rules:
- Type: MySQL/Aurora (3306)
  Source: Dev-App-SG
- Type: PostgreSQL (5432)
  Source: Dev-App-SG

Outbound Rules:
- Type: All Traffic
  Destination: 0.0.0.0/0
```
![](/images/4.spoke-vpcs/hinh-50.png)
![](/images/4.spoke-vpcs/hinh-51.png)
![](/images/4.spoke-vpcs/hinh-52.png)