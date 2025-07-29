---
title: "Advanced Connection Testing"
date: "`r Sys.Date()`"
menu : "main"
weight: 2
chapter : false
pre : " <b> 6.1.2 </b> "
---

### 1.2 Advanced Connection Testing

This section tests connectivity to specific ports, performed from the **Hub VPC's Bastion Host**.

**Note:**
*   Replace placeholder IP addresses (`10.1.1.10`, `10.2.1.10`, `10.1.11.10`) with the **actual private IPs** of the corresponding instances.
*   Ensure the `nc` (netcat) tool is installed on the Bastion Host.

#### Tests and Expected Results:

*   **SSH access test (port 22):**
    *   **Command:** `nc -zv <IP_instance_Production> 22` and `nc -zv <IP_instance_Development> 22`

![](/images/6.testing-monitoring/hinh-6.png)
    *   **Expected Result:** `SUCCESS`. The Bastion Host is allowed to SSH into internal instances.

*   **HTTP/HTTPS test (ports 80/443):**
    *   **Command:** `nc -zv <IP_instance_Production> 80` and `nc -zv <IP_instance_Production> 443`

![](/images/6.testing-monitoring/hinh-7.png)
    *   **Expected Result:** Can be `SUCCESS` or `FAILURE` (timeout/connection refused). It will usually `FAIL` if the instance's Security Group only allows access from the Load Balancer, which is a good security configuration.

*   **Database port tests (ports 3306/5432):**
    *   **Command:** `nc -zv <IP_instance_DB_Production> 3306` and `nc -zv <IP_instance_DB_Production> 5432`

![](/images/6.testing-monitoring/hinh-8.png)
    *   **Expected Result:** `FAILURE` (timeout/connection refused). Database ports **should be blocked** from direct access from the Bastion Host for security, they should only be accessed from the application layer.

*   **VPC Endpoints test (port 443):**
    *   **Command:** `nc -zv s3.ap-southeast-1.amazonaws.com 443` and `nc -zv ec2.ap-southeast-1.amazonaws.com 443`

![](/images/6.testing-monitoring/hinh-9.png)
    *   **Expected Result:** `SUCCESS`. Confirms VPC Endpoint is working, allowing access to AWS services without going over the internet.
