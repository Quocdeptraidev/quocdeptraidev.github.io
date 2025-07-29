---
title: "Advanced Topic (Optional): Resource Sharing"
date: "2025-07-12"
weight: 6
menu : "main"
chapter : false
pre : " <b> 2.6 </b> "
---

If you want to share this Transit Gateway with other AWS accounts within the same AWS Organization, you can use **AWS Resource Access Manager (RAM)**.

1.  Open the **AWS Resource Access Manager (RAM)** service.
2.  Click **Create resource share**.
3.  Select `Transit Gateways` as the resource type and choose `Hub-TGW`.
4.  In **Principals**, enter the AWS account ID or the OU of the organization you want to share with.
