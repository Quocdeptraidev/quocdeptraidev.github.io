---
title : "Update Route Tables with Transit Gateway"
date :  "2025-07-13" 
menu : "main"
weight : 6
chapter : false
pre : " <b> 4.6 </b> "
---

## Step 8: Update Route Tables with Transit Gateway

After the attachments are created, update the route tables. **Note:** When adding a route in the VPC Route Table, the Target must be the **Transit Gateway ID** (`tgw-xxxxxxxxxxxxxxxxx`), not the Attachment ID.

### 8.1 Update Hub VPC Route Tables

1. Select **Hub-TGW-RT** (the VPC Route Table in the Hub VPC, associated with the Hub's TGW Subnets)
2. Edit routes, add:

![](/images/4.spoke-vpcs/hinh-61.png)
```
- 10.1.0.0/16 → tgw-xxxxxxxxxxxxxxxxx (ID of Hub-TGW, to Production)
- 10.2.0.0/16 → tgw-xxxxxxxxxxxxxxxxx (ID of Hub-TGW, to Development)
- 0.0.0.0/0 → tgw-xxxxxxxxxxxxxxxxx (ID of Hub-TGW, if you want internet traffic from Spoke VPCs to go through the Hub)
```
![](/images/4.spoke-vpcs/hinh-62.png)
### 8.2 Update Spoke VPC Route Tables

Update all route tables in the Production and Development VPCs to point the default route (0.0.0.0/0) to the Transit Gateway, and other routes to the Hub VPC/other Spoke VPCs.
#### For Production VPC Route Tables (Prod-App-RT, Prod-DB-RT, Prod-TGW-RT):

```
- 0.0.0.0/0 → tgw-xxxxxxxxxxxxxxxxx (ID of Hub-TGW)
- 10.0.0.0/16 → tgw-xxxxxxxxxxxxxxxxx (ID of Hub-TGW, to Hub)
- 10.2.0.0/16 → tgw-xxxxxxxxxxxxxxxxx (ID of Hub-TGW, to Dev, if needed)
```
![](/images/4.spoke-vpcs/hinh-63.png)
![](/images/4.spoke-vpcs/hinh-64.png)
![](/images/4.spoke-vpcs/hinh-65.png)
#### For Development VPC Route Tables (Dev-App-RT, Dev-DB-RT, Dev-TGW-RT):

```
- 0.0.0.0/0 → tgw-xxxxxxxxxxxxxxxxx (ID of Hub-TGW)
- 10.0.0.0/16 → tgw-xxxxxxxxxxxxxxxxx (ID of Hub-TGW, to Hub)
- 10.1.0.0/16 → tgw-xxxxxxxxxxxxxxxxx (ID of Hub-TGW, to Prod, if needed)
```
![](/images/4.spoke-vpcs/hinh-66.png)
![](/images/4.spoke-vpcs/hinh-67.png)
![](/images/4.spoke-vpcs/hinh-68.png)