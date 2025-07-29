---
title: "Verify Configuration"
date: "2025-07-12"
weight: 4
menu : "main"
chapter : false
pre : " <b> 2.4 </b> "
---

### 4.1. Check Transit Gateway Status

1.  In the VPC Console, select **Transit Gateways**.
2.  Verify that the status of `Hub-TGW` is **Available**.

![](/images/2.transit-gateway/hinh13.png)
3.  Record the **Transit Gateway ID** for use in subsequent steps.

### 4.2. Check Route Tables

1.  Select **Transit Gateway Route Tables**.
2.  Verify that the `Hub-Route-Table` and `Spoke-Route-Table` tables have been created successfully and that the default route table has no Associations or Propagations.

![](/images/2.transit-gateway/hinh14.png)
