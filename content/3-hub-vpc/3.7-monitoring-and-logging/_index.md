---
title: "Monitoring and Logging (VPC Flow Logs)"
date :  "`r Sys.Date()`" 
menu : "main"
weight : 7
chapter : false
pre : " <b> 3.7 </b> "
---


## Step 7: Monitoring and Logging (VPC Flow Logs)

To monitor network traffic in the Hub VPC, we will enable VPC Flow Logs.

### 7.1 Enable VPC Flow Logs

1.  In the VPC Console, select **Your VPCs**.
2.  Select **Hub-VPC**.
3.  Select the **Flow Logs** tab, click **Create flow log**.
4.  Configure as follows:
    | Parameter | Value |
    | :--- | :--- |
    | **Name** | `hub-vpc-flow-log` |
    | **Filter** | `All` (Log both accepted and rejected traffic). |
    | **Maximum aggregation interval** | `10 minutes` |
    | **Destination** | `Send to CloudWatch Logs` |
    | **Destination log group** | Create a new log group, e.g., `/aws/vpc-flow-logs/hub-vpc` |
    | **Log record format** | `AWS default format` |
5.  Click **Create flow log**.

### 7.2 Monitor Metrics on CloudWatch

Transit Gateway automatically sends metrics to CloudWatch:
- **BytesIn/BytesOut**: Data transfer volume.
- **PacketsIn/PacketsOut**: Number of packets.
- **PacketDropCount**: Number of packets dropped due to no route or ACLs.
