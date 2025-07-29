---
title: "Create Custom Route Tables"
date: "2025-07-12"
weight: 2
menu : "main"
chapter : false
pre : " <b> 2.2 </b> "
---

To better control traffic flow, we will create custom route tables instead of using the default table.

### 2.1. Create a Route Table for the Hub

1.  In the VPC Console, in the left menu, select **Transit Gateway Route Tables**.

![](/images/2.transit-gateway/hinh8.png)
2.  Click **Create Transit Gateway Route Table**.

![](/images/2.transit-gateway/hinh9.png)

3.  Configuration:
    | Parameter | Value |
    | :--- | :--- |
    | **Name tag** | `Hub-Route-Table` |
    | **Transit Gateway ID** | Select the `Hub-TGW` created in Step 1. |

![](/images/2.transit-gateway/hinh10.png)
4.  Click **Create Transit Gateway Route Table**.

![](/images/2.transit-gateway/hinh11.png)
### 2.2. Create a Route Table for the Spoke

1.  Click **Create Transit Gateway Route Table** again.
2.  Configuration:
    | Parameter | Value |
    | :--- | :--- |
    | **Name tag** | `Spoke-Route-Table` |
    | **Transit Gateway ID** | Select `Hub-TGW`. |

![](/images/2.transit-gateway/hinh12.png)
3.  Click **Create Transit Gateway Route Table**.
