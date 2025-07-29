---
title: "Configure Default Route Table"
date: "2025-07-12"
weight: 3
menu : "main"
chapter : false
pre : " <b> 2.3 </b> "
---

### 3.1. Disable Default Association and Propagation

We will disable the default behaviors on the Transit Gateway's original route table to ensure complete control.

1.  Navigate to **Transit Gateway Route Tables**.
2.  Select the **default** route table for `Hub-TGW` (the one not named `Hub-Route-Table` or `Spoke-Route-Table`).
3.  Select the **Associations** tab, select all associations, and click **Delete association**.
4.  Select the **Propagations** tab, select all propagations, and click **Delete propagation**.

{{% notice note %}}
If the **Associations** and **Propagations** tabs are already empty, you do not need to perform the deletion and can skip this step.
{{% /notice %}}

{{% notice warning %}}
Disabling the default route table ensures that you have full control over traffic flow and avoid unintended connections.
{{% /notice %}}
