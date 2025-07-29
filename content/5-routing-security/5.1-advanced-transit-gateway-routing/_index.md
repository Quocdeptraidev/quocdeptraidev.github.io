---
title: "Advanced Transit Gateway Routing"
menu : "main"
weight: 1
chapter : false
pre : " <b> 5.1 </b> "
---


In this section, we will configure the core components of routing within the Transit Gateway to establish the foundation for our network architecture.

## Overview of Advanced Routing

Advanced routing in Transit Gateway allows for:

- **Detailed traffic control** between VPCs
- **Security segmentation** by environment
- **Traffic inspection** and monitoring
- **Conditional routing** based on source/destination

### 1.1 Create Dedicated Route Tables

We begin by creating separate route tables for different purposes, allowing for granular control over traffic flow.

#### Security Route Table
This route table will be used for inspecting traffic that passes through security appliances.
```
Name: Security-Route-Table
Description: Route table for security inspection
Transit Gateway: Enterprise-TGW
```
![](/images/5.routing-security/hinh-1.png)
#### Inspection Route Table
This route table is intended for traffic inspection and monitoring.
```
Name: Inspection-Route-Table
Description: Route table for traffic inspection
Transit Gateway: Enterprise-TGW
```
![](/images/5.routing-security/hinh-2.png)
### 1.2 Configure the Hub Route Table

The Hub VPC's route table will direct traffic to the Spoke VPCs and to the internet.

1.  Select **Hub-Route-Table**
2.  Click the **Routes** tab
3.  Click **Create route**
4.  Add the following routes:

```
Routes:
- 10.1.0.0/16 → Production VPC Attachment
- 10.2.0.0/16 → Development VPC Attachment
- 0.0.0.0/0 → Hub VPC Attachment (for internet access)
```

### 1.3 Configure the Spoke Route Table

The Spoke VPCs' route table will direct all traffic to the Hub VPC for centralized processing.

1.  Select **Spoke-Route-Table**
2.  Add the following routes:

```
Routes:
- 0.0.0.0/0 → Hub VPC Attachment (internet via Hub NAT)
- 10.0.0.0/16 → Hub VPC Attachment (shared services)
```

### 1.4 Implement Route Propagation

Enable route propagation so that Spoke VPCs can automatically learn routes from the Hub.

```bash
# Enable route propagation for the Hub route table
aws ec2 create-transit-gateway-route-table-propagation \
    --transit-gateway-attachment-id tgw-attach-xxxxxxxxx \
    --transit-gateway-route-table-id tgw-rtb-xxxxxxxxx
```
![](/images/5.routing-security/hinh-3.png)

```

In this section, we will configure the core components of routing within the Transit Gateway to establish the foundation for our network architecture.

### 1.1 Create Dedicated Route Tables

We begin by creating separate route tables for different purposes, allowing for granular control over traffic flow.

#### Security Route Table
This route table will be used for inspecting traffic that passes through security appliances.
```
Name: Security-Route-Table
Description: Route table for security inspection
Transit Gateway: Enterprise-TGW
```
![](/images/5.routing-security/hinh-1.png)

#### Inspection Route Table
This route table is intended for traffic inspection and monitoring.
```
Name: Inspection-Route-Table
Description: Route table for traffic inspection
Transit Gateway: Enterprise-TGW
```
![](/images/5.routing-security/hinh-2.png)

### 1.2 Configure the Hub Route Table

The Hub VPC's route table will direct traffic to the Spoke VPCs and to the internet.

1.  Select **Hub-Route-Table**
2.  Click the **Routes** tab
3.  Click **Create route**
4.  Add the following routes:

```
Routes:
- 10.1.0.0/16 → Production VPC Attachment
- 10.2.0.0/16 → Development VPC Attachment
- 0.0.0.0/0 → Hub VPC Attachment (for internet access)
```

### 1.3 Configure the Spoke Route Table

The Spoke VPCs' route table will direct all traffic to the Hub VPC for centralized processing.

1.  Select **Spoke-Route-Table**
2.  Add the following routes:

```
Routes:
- 0.0.0.0/0 → Hub VPC Attachment (internet via Hub NAT)
- 10.0.0.0/16 → Hub VPC Attachment (shared services)
```

### 1.4 Implement Route Propagation

Enable route propagation so that Spoke VPCs can automatically learn routes from the Hub.

```bash
# Enable route propagation for the Hub route table
aws ec2 create-transit-gateway-route-table-propagation \
    --transit-gateway-attachment-id tgw-attach-xxxxxxxxx \
    --transit-gateway-route-table-id tgw-rtb-xxxxxxxxx
```
![](/images/5.routing-security/hinh-3.png)

```