---
title: "Basic Connection Testing"
date: "`r Sys.Date()`"
menu : "main"
weight: 1
chapter : false
pre : " <b> 6.1.1 </b> "
---

### 1.1 Basic Connection Testing

These tests are performed from the **Hub VPC's Bastion Host** to verify basic network connectivity between VPCs and the Internet.

**Note:**
*   Replace placeholder IP addresses (`10.1.1.10`, `10.2.1.10`, etc.) with the **actual private IPs** of instances in your Production and Development VPCs.
*   Ensure tools like `ping`, `ssh`, `curl`, and `nc` (netcat) are installed on the Bastion Host and target instances if needed.
*   If using `ssh` to run commands on target instances, ensure the corresponding SSH key (`.pem` file) has been copied to the Bastion Host and has appropriate permissions (`chmod 400`).

#### Tests and Expected Results:

1.  **Hub to Production/Development Connectivity Test (using `ping`):**
    *   **Command:** `ping -c 3 <IP_instance_Production>` and `ping -c 3 <IP_instance_Development>`
![](/images/6.testing-monitoring/hinh-1.png)
![](/images/6.testing-monitoring/hinh-2.png)
    *   **Expected Result:** `SUCCESS` (0% packet loss). This confirms basic connectivity between the Hub and spoke VPCs.

2.  **Production to Development Isolation Test (using `ssh` and `ping`):**
    *   **Command:** `ssh -o ConnectTimeout=5 ec2-user@<IP_instance_Production> "ping -c 1 <IP_instance_Development>"`
    ![](/images/6.testing-monitoring/hinh-3.png)
    *   **Expected Result:** `SUCCESS` (100% packet loss for `ping` inside). This confirms that traffic between Production and Development is blocked, ensuring isolation as designed.

3.  **Internet Connectivity Test from Spoke VPCs (using `ssh` and `curl`):**
    *   **Command:** `ssh -i <Path_to_your_SSH_Key.pem> ec2-user@<IP_Production_Instance_AZ1a> "curl -s --connect-timeout 5 http://google.com"` and similarly for Development.
    ![](/images/6.testing-monitoring/hinh-4.png)
    ![](/images/6.testing-monitoring/hinh-5.png)
    *   **Expected Result:** `SUCCESS` (returns a short HTML code). This confirms that instances in spoke VPCs can access the Internet via the Hub VPC's NAT Gateway.
