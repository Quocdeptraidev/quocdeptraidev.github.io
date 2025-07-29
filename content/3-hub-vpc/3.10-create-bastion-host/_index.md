---
title: "Create Bastion Host (Optional)"
date :  "`r Sys.Date()`" 
menu : "main"
weight : 10
chapter : false
pre : " <b> 3.10 </b> "
---


## Step 10: Create Bastion Host (Optional)

### 10.1 Launch EC2 Instance

1. In the EC2 Console, click **Launch Instance**

![](/images/3.hub-vpc/hinh-60.png)
2. Configure as follows:

```
Name: Hub-Bastion-Host
AMI: Amazon Linux 2023
Instance type: t3.micro
Key pair: Create new or use existing
Network settings:
  - VPC: Hub-VPC
  - Subnet: Hub-Public-Subnet-1a
  - Auto-assign public IP: Enable
  - Security group: Create new
```

![](/images/3.hub-vpc/hinh-61.png)
![](/images/3.hub-vpc/hinh-62.png)
![](/images/3.hub-vpc/hinh-63.png)
![](/images/3.hub-vpc/hinh-64.png)
### 10.2 Create and Attach IAM Role for Bastion Host

To allow the Bastion Host to access AWS services (like S3, EC2) without manual credential configuration, you need to create and attach an IAM Role to it.

1.  **Create IAM Role:**
    *   Open the AWS Console and navigate to the **IAM** service.
    *   In the left navigation pane, select **Roles**.
    *   Click the **Create role** button.
    *   Select **AWS service** as the trusted entity type, then choose **EC2** as the use case.
    *   Click **Next**.
    *   In the **Add permissions** section, search for and select the following policies:
        *   `AmazonS3ReadOnlyAccess`
        *   `AmazonEC2ReadOnlyAccess`
        *   `AmazonSSMReadOnlyAccess`
        *   `CloudWatchLogsReadOnlyAccess`
        *   `AWSVPCReadOnlyAccess`
    *   Click **Next**.
    *   Give the Role a name, for example: `BastionHostAccessRole`.
    *   Click **Create role**.

![](/images/3.hub-vpc/hinh-71.png)

2.  **Attach IAM Role to Bastion Host:**
    *   Open the AWS Console and navigate to the **EC2** service.
    *   In the left navigation pane, select **Instances**.
    *   Find and select your EC2 instance named **`Hub-Bastion-Host`**.
    *   Click **Actions** -> **Security** -> **Modify IAM role**.

![](/images/3.hub-vpc/hinh-72.png)
    *   In the **IAM role** dropdown list, select the **`BastionHostAccessRole`** you just created.
![](/images/3.hub-vpc/hinh-73.png)
    *   Click **Update IAM role**.

### 10.3 Bastion Security Group

```
Name: Hub-Bastion-SG
Description: Security group for bastion host

Inbound Rules:
- Type: SSH (22)
  Source: Your IP address

Outbound Rules:
- Type: All Traffic
  Destination: 0.0.0.0/0
```
![](/images/3.hub-vpc/hinh-65.png)
