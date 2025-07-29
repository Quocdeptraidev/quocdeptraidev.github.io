---
title: "Create VPC Endpoints"
date :  "`r Sys.Date()`" 
menu : "main"
weight : 8
chapter : false
pre : " <b> 3.8 </b> "
---

## Step 8: Create VPC Endpoints

### 8.1 S3 Gateway Endpoint

1. In the VPC Console, select **Endpoints**
2. Click **Create Endpoint**

![](/images/3.hub-vpc/hinh-44.png)
3. Configure as follows:

```
Name tag: Hub-S3-Endpoint
Service category: AWS services
Service Name: com.amazonaws.ap-southeast-1.s3 (Type: Gateway)
VPC: Hub-VPC
Route tables: Select the private route tables (Hub-Private-RT-1a, Hub-Private-RT-1b)
Policy: Full access
```
![](/images/3.hub-vpc/hinh-45.png)
![](/images/3.hub-vpc/hinh-46.png)
![](/images/3.hub-vpc/hinh-47.png)
4. Click **Create Endpoint**

### 8.2.1 Create Security Group for VPC Endpoints

Before creating Interface Endpoints, you need to create a Security Group to control traffic to them.

1.  In the VPC Console, select **Security Groups**.
2.  Click **Create security group**.
3.  Configure as follows:
    | Parameter | Value |
    | :--- | :--- |
    | **Security group name** | `Hub-VPCEndpoint-SG` |
    | **Description** | `Security group for VPC Endpoints in Hub VPC` |
    | **VPC** | `Hub-VPC` |
    | **Inbound rules** | Type: `HTTPS` (Port 443), Source: `10.0.0.0/16` (Hub-VPC CIDR) |
    | **Outbound rules** | Type: `All Traffic`, Destination: `0.0.0.0/0` |

![](/images/3.hub-vpc/hinh-48.png)
![](/images/3.hub-vpc/hinh-49.png)

4.  Click **Create security group**.

### 8.2 EC2 Interface Endpoint

```
Name tag: Hub-EC2-Endpoint
Service category: AWS services
Service Name: com.amazonaws.ap-southeast-1.ec2 (Type: Interface)
VPC: Hub-VPC
Subnets: Hub-Private-Subnet-1a, Hub-Private-Subnet-1b
Security groups: Hub-VPCEndpoint-SG
Policy: Full access

**Note:** Uncheck "Enable Private DNS Name" (if this option is available).
```
![](/images/3.hub-vpc/hinh-50.png)
![](/images/3.hub-vpc/hinh-51.png)
![](/images/3.hub-vpc/hinh-52.png)
![](/images/3.hub-vpc/hinh-53.png)
### 8.3 SSM Interface Endpoints

Create endpoints for Systems Manager:

```
Endpoints to create:
- com.amazonaws.ap-southeast-1.ssm
- com.amazonaws.ap-southeast-1.ssmmessages
- com.amazonaws.ap-southeast-1.ec2messages
```
![](/images/3.hub-vpc/hinh-54.png)
![](/images/3.hub-vpc/hinh-55.png)
