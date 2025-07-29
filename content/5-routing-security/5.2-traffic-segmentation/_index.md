---
title: "Traffic Segmentation"
menu : "main"
weight: 2
chapter : false
pre : " <b> 5.2 </b> "
---

Traffic segmentation is a critical security measure to isolate environments and control communication between them.

{{% notice info %}}
**Note on an Advanced Security Layer: AWS Network Firewall**

In addition to using Security Groups and Network ACLs, in production environments with high-security requirements, **AWS Network Firewall** is often deployed in the Hub VPC. This is a managed firewall service that allows you to implement detailed filtering rules for all traffic passing through the Transit Gateway.

**Key Benefits:**
- **Centralized Traffic Inspection and Filtering:** Instead of managing complex rules across multiple NACLs, you can define security policies in a single place.
- **Enhanced Protection:** Provides capabilities like Intrusion Prevention (IPS), web filtering, and traffic inspection based on more complex rules.

In our architecture, the AWS Network Firewall would be placed in the Hub VPC, and all traffic from the Spoke VPCs would be routed through it before going to the internet or other VPCs.
{{% /notice %}}

### 2.1 Isolate Production-Development

To prevent direct communication between the Production and Development environments, we create separate route tables.

1.  Create **Prod-Only-Route-Table**:
![](/images/5.routing-security/hinh-4.png)
    ```
    Routes:
    - 10.0.0.0/16 → Hub VPC (shared services only)
    - 0.0.0.0/0 → Hub VPC (internet access)
    # NO route to 10.2.0.0/16 (Development)
    ```
![](/images/5.routing-security/hinh-5.png)

2.  Create **Dev-Only-Route-Table**:
![](/images/5.routing-security/hinh-6.png)
    ```
    Routes:
    - 10.0.0.0/16 → Hub VPC (shared services only)
    - 0.0.0.0/0 → Hub VPC (internet access)
    # NO route to 10.1.0.0/16 (Production)
    ```
![](/images/5.routing-security/hinh-7.png)

3.  Re-associate the VPC attachments:
    -   Production VPC → Prod-Only-Route-Table
    -   Development VPC → Dev-Only-Route-Table

### 2.2 Conditional Routing

Implement conditional routing based on the source to control access to specific services.

```bash
# Route from Production to specific services only
aws ec2 create-route \
    --route-table-id tgw-rtb-prod \
    --destination-cidr-block 10.0.10.0/24 \
    --transit-gateway-attachment-id tgw-attach-hub
```
![](/images/5.routing-security/hinh-8.png)
