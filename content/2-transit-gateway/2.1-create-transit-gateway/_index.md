---
title: "Create a Transit Gateway"
date: "2025-07-12"
weight: 1
menu : "main"
chapter : false
pre : " <b> 2.1 </b> "
---

### 1.1. Access AWS Console

1.  Log in to the [AWS Management Console](https://aws.amazon.com/console/).
2.  Select the **Asia Pacific (Singapore) `ap-southeast-1`** Region.

![Asia Pacific (Singapore)](/images/2.transit-gateway/hinh1.png)
3.  In the search bar, type **VPC** and select the VPC service.

![](/images/2.transit-gateway/hinh2.png)
4.  In the left navigation pane, select **Transit Gateways**.

![](/images/2.transit-gateway/hinh3.png)
### 1.2. Configure and Create Transit Gateway

1.  Click the **Create Transit Gateway** button.

![](/images/2.transit-gateway/hinh4.png)
2.  Fill in the configuration parameters as follows:

| Parameter | Value | Notes |
| :--- | :--- | :--- |
| **Name tag** | `Hub-TGW` | A name to easily identify the Transit Gateway. |
| **Description** | `Transit Gateway for the central hub` | A description of the Transit Gateway's purpose. |
| **Amazon side ASN** | `64512` | The Autonomous System Number (ASN) for the Amazon side. You can leave the default. |
| **DNS support** | `Enable` | Allows DNS resolution between VPCs. |
| **VPN ECMP support** | `Enable` | Enables Equal-Cost Multi-Path routing for VPN connections. |
| **Default route table association** | `Enable` | Automatically associates new attachments with the default route table. |
| **Default route table propagation** | `Enable` | Automatically propagates routes from new attachments to the default route table. |
| **Multicast support** | `Disable` | Disable if you do not need to use multicast. |
| **Auto accept shared attachments** | `Enable` | Automatically accepts attachments shared from other accounts. |

![](/images/2.transit-gateway/hinh5.png)
![](/images/2.transit-gateway/hinh6.png)
3.  Click **Create Transit Gateway**.

![](/images/2.transit-gateway/hinh7.png)
{{% notice info %}}
The Transit Gateway creation process can take 10–15 minutes to complete. The status will change from `pending` to `available`.
{{% /notice %}}
