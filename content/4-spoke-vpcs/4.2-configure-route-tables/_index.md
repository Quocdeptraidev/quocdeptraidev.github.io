---
title : "Configure Route Tables for Production VPC"
date :  "2025-07-13" 
menu : "main"
weight : 2
chapter : false
pre : " <b> 4.2 </b> "
---

## Step 3: Configure Route Tables for Production VPC

### 3.1 Application Route Table

1. Select **Route Tables**
2. Click **Create Route Table**
3. Configure:

```
Name: Prod-App-RT
VPC: Production-VPC
```
![](/images/4.spoke-vpcs/hinh-21.png)
4. Edit routes:

```
Routes:
- 10.1.0.0/16 → local (auto-created)
- 0.0.0.0/0 → Transit Gateway (to be added in Step 8)
- 10.0.0.0/16 → Transit Gateway (to be added in Step 8)
- 10.2.0.0/16 → Transit Gateway (to be added in Step 8)
```

{{% notice info %}}
Routes to the Transit Gateway will be added in **Step 8** after the VPC is attached to the Transit Gateway. When adding a route in the VPC Route Table, the Target must be the **Transit Gateway ID** (`tgw-xxxxxxxxxxxxxxxxx`), not the Attachment ID.
{{% /notice %}}

5. Associate subnets:
   - Prod-App-Subnet-1a
   - Prod-App-Subnet-1b

![](/images/4.spoke-vpcs/hinh-22.png)
### 3.2 Database Route Table

```
Name: Prod-DB-RT
VPC: Production-VPC

Routes:
- 10.1.0.0/16 → local (auto-created)
- 10.0.0.0/16 → Transit Gateway (to be added in Step 8)
```

{{% notice info %}}
Routes to the Transit Gateway will be added in **Step 8** after the VPC is attached to the Transit Gateway. When adding a route in the VPC Route Table, the Target must be the **Transit Gateway ID** (`tgw-xxxxxxxxxxxxxxxxx`), not the Attachment ID.
{{% /notice %}}

Subnet Associations:
- Prod-DB-Subnet-1a
- Prod-DB-Subnet-1b

![](/images/4.spoke-vpcs/hinh-23.png)
![](/images/4.spoke-vpcs/hinh-24.png)
### 3.3 Transit Gateway Route Table

```
Name: Prod-TGW-RT
VPC: Production-VPC

Routes:
- 10.1.0.0/16 → local (auto-created)
- 0.0.0.0/0 → Transit Gateway (to be added in Step 8)
- 10.0.0.0/16 → Transit Gateway (to be added in Step 8)
- 10.2.0.0/16 → Transit Gateway (to be added in Step 8)
```

{{% notice info %}}
Routes to the Transit Gateway will be added in **Step 8** after the VPC is attached to the Transit Gateway. When adding a route in the VPC Route Table, the Target must be the **Transit Gateway ID** (`tgw-xxxxxxxxxxxxxxxxx`), not the Attachment ID.
{{% /notice %}}

Subnet Associations:
- Prod-TGW-Subnet-1a
- Prod-TGW-Subnet-1b

![](/images/4.spoke-vpcs/hinh-25.png)
![](/images/4.spoke-vpcs/hinh-26.png)

## Step 4: Configure Route Tables for Development VPC

### 4.1 Application Route Table

```
Name: Dev-App-RT
VPC: Development-VPC

Routes:
- 10.2.0.0/16 → local (auto-created)
- 0.0.0.0/0 → Transit Gateway (to be added in Step 8)
- 10.0.0.0/16 → Transit Gateway (to be added in Step 8)
- 10.1.0.0/16 → Transit Gateway (to be added in Step 8)
```

{{% notice info %}}
Routes to the Transit Gateway will be added in **Step 8** after the VPC is attached to the Transit Gateway. When adding a route in the VPC Route Table, the Target must be the **Transit Gateway ID** (`tgw-xxxxxxxxxxxxxxxxx`), not the Attachment ID.
{{% /notice %}}

Subnet Associations:
- Dev-App-Subnet-1a
- Dev-App-Subnet-1b

![](/images/4.spoke-vpcs/hinh-27.png)
![](/images/4.spoke-vpcs/hinh-28.png)
### 4.2 Database Route Table

```
Name: Dev-DB-RT
VPC: Development-VPC

Routes:
- 10.2.0.0/16 → local (auto-created)
- 10.0.0.0/16 → Transit Gateway (to be added in Step 8)
```

{{% notice info %}}
Routes to the Transit Gateway will be added in **Step 8** after the VPC is attached to the Transit Gateway. When adding a route in the VPC Route Table, the Target must be the **Transit Gateway ID** (`tgw-xxxxxxxxxxxxxxxxx`), not the Attachment ID.
{{% /notice %}}

Subnet Associations:
- Dev-DB-Subnet-1a
- Dev-DB-Subnet-1b

![](/images/4.spoke-vpcs/hinh-29.png)
![](/images/4.spoke-vpcs/hinh-30.png)
### 4.3 Transit Gateway Route Table

```
Name: Dev-TGW-RT
VPC: Development-VPC

Routes:
- 10.2.0.0/16 → local (auto-created)
- 0.0.0.0/0 → Transit Gateway (to be added in Step 8)
- 10.0.0.0/16 → Transit Gateway (to be added in Step 8)
```

{{% notice info %}}
Routes to the Transit Gateway will be added in **Step 8** after the VPC is attached to the Transit Gateway. When adding a route in the VPC Route Table, the Target must be the **Transit Gateway ID** (`tgw-xxxxxxxxxxxxxxxxx`), not the Attachment ID.
{{% /notice %}}

Subnet Associations:
- Dev-TGW-Subnet-1a
- Dev-TGW-Subnet-1b

![](/images/4.spoke-vpcs/hinh-31.png)
![](/images/4.spoke-vpcs/hinh-32.png)