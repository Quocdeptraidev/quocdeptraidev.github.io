---
title: "DNS Resolution Testing"
date: "`r Sys.Date()`"
menu : "main"
weight: 3
chapter : false
pre : " <b> 6.1.3 </b> "
---

### 1.3 DNS Resolution Testing

This section verifies the domain name resolution capabilities of instances, both internal and external. These tests are performed from the **Hub VPC's Bastion Host**.

**Note:**
*   Ensure the `nslookup` tool is installed on the Bastion Host (e.g., `sudo yum install bind-utils -y` or `sudo apt install dnsutils -y`).
*   Replace placeholder IP addresses and internal DNS names with your actual values.

#### Tests and Expected Results:

*   **Internal DNS resolution test:**
    *   **Command:** `nslookup ip-<IP_instance_Production_or_Development_with_hyphens>.ap-southeast-1.compute.internal`

![](/images/6.testing-monitoring/hinh-10.png)
    *   **Expected Result:** `SUCCESS` (returns the corresponding IP address). Confirms the VPC's DNS Resolver can resolve internal DNS names.

*   **External DNS resolution test:**
    *   **Command:** `nslookup google.com`

![](/images/6.testing-monitoring/hinh-11.png)
    *   **Expected Result:** `SUCCESS` (returns google.com's public IP address). Confirms external domain names can be resolved.

*   **DNS VPC Endpoint test:**
    *   **Command:** `nslookup s3.ap-southeast-1.amazonaws.com` (or other services)

![](/images/6.testing-monitoring/hinh-12.png)
    *   **Expected Result:** `SUCCESS` (returns the private IP address of the VPC Endpoint in your VPC). Confirms the VPC Endpoint is working, allowing access to AWS services without going over the internet.

*   **Reverse DNS resolution test:**
    *   **Command:** `nslookup <IP_instance_Production_or_Development>`

![](/images/6.testing-monitoring/hinh-13.png)
    *   **Expected Result:** `SUCCESS` (returns the internal DNS name of the corresponding instance). Confirms the DNS Resolver can resolve IP addresses to DNS names.
