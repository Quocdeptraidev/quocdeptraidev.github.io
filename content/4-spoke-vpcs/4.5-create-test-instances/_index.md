---
title : "Create Test Instances"
date :  "2025-07-13" 
menu : "main"
weight : 5
chapter : false
pre : " <b> 4.5 </b> "
---

## Step 7: Create Test Instances

### 7.1 Production Test Instance

1. In the EC2 Console, click **Launch Instance**
2. Configure:

```
Name: Prod-Test-Instance
AMI: Amazon Linux 2023
Instance type: t3.micro
Key pair: Use existing or create new
Network settings:
  - VPC: Production-VPC
  - Subnet: Prod-App-Subnet-1a
  - Auto-assign public IP: Disable
  - Security group: Prod-App-SG
```
![](/images/4.spoke-vpcs/hinh-53.png)
![](/images/4.spoke-vpcs/hinh-54.png)
![](/images/4.spoke-vpcs/hinh-55.png)
![](/images/4.spoke-vpcs/hinh-56.png)
### 7.2 Development Test Instance

```
Name: Dev-Test-Instance
AMI: Amazon Linux 2023
Instance type: t3.micro
Key pair: Use existing or create new
Network settings:
  - VPC: Development-VPC
  - Subnet: Dev-App-Subnet-1a
  - Auto-assign public IP: Disable
  - Security group: Dev-App-SG
```
![](/images/4.spoke-vpcs/hinh-57.png)
![](/images/4.spoke-vpcs/hinh-58.png)
![](/images/4.spoke-vpcs/hinh-59.png)
![](/images/4.spoke-vpcs/hinh-60.png)