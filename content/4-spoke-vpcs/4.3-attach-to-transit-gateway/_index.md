---
title: "Attach Spoke VPCs to Transit Gateway"
date: "2025-07-13"
menu : "main"
weight : 3
chapter : false
pre : " <b> 4.3 </b> "
---

## Step 5: Attach Spoke VPCs to Transit Gateway

---

### 5.1 Attach Production VPC

1. Vào **VPC Console**, chọn **Transit Gateway Attachments**  
2. Click **Create Transit Gateway Attachment**  
3. Cấu hình như sau:

    ```yaml
    Name tag: Prod-VPC-TGW-Attachment
    Transit Gateway ID: Hub-TGW
    Attachment type: VPC
    VPC ID: Production-VPC
    Subnet IDs: 
      - Prod-TGW-Subnet-1a
      - Prod-TGW-Subnet-1b
    ```

    ![](/images/4.spoke-vpcs/hinh-33.png)  
    ![](/images/4.spoke-vpcs/hinh-34.png)

4. Click **Create Transit Gateway Attachment**

---

### 5.2 Attach Development VPC

Cấu hình:

```yaml
Name tag: Dev-VPC-TGW-Attachment
Transit Gateway ID: Hub-TGW
Attachment type: VPC
VPC ID: Development-VPC
Subnet IDs: 
  - Dev-TGW-Subnet-1a
  - Dev-TGW-Subnet-1b
