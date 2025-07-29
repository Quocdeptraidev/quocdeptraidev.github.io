---
title: "Network Latency Testing"
date: "`r Sys.Date()`"
menu : "main"
weight: 1
chapter : false
pre : " <b> 6.2.1 </b> "
---

### 2.1 Network Latency Testing

This section measures the latency between your Bastion Host and different points in the network. These tests are performed from the **Hub VPC's Bastion Host**.

**Note:**
*   Replace placeholder IP addresses (`10.1.1.10`, `10.1.2.10`, `10.0.1.10`) with the **actual private IPs** of the corresponding instances.
*   `10.1.1.10` is the IP of the Production instance (same AZ).
*   `10.1.2.10` is the IP of the Production instance in a different AZ (or Development instance if no multi-AZ Prod).
*   `10.0.1.10` is the IP of an instance/resource in the Hub VPC.

#### Tests and Expected Results:

*   **Latency test within the same AZ (or to Production VPC):**
    *   **Command:** `ping -c 10 <IP_instance_Production>`
![](/images/6.testing-monitoring/hinh-14.png)
    *   **Expected Result:** Very low latency (under 1ms or a few ms).

*   **Latency test between AZs (within Production VPC):**
    *   **Command:** `ping -c 10 <IP_instance_Production_different_AZ>`

![](/images/6.testing-monitoring/hinh-15.png)
    *   **Expected Result:** Low latency (a few ms), slightly higher than within the same AZ.

*   **Latency test to Hub VPC:**
    *   **Command:** `ping -c 10 <IP_instance_Hub>`

![](/images/6.testing-monitoring/hinh-16.png)
    *   **Expected Result:** Very low latency (under 1ms or a few ms).

*   **Latency test to the internet:**
    *   **Command:** `ping -c 10 8.8.8.8`

![](/images/6.testing-monitoring/hinh-17.png)
    *   **Expected Result:** Significantly higher latency (tens to hundreds of ms). *Note: Your actual latency (~0.9ms) is extremely low and indicates excellent network performance.*
