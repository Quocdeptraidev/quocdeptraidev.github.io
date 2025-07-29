---
title: "Network ACL Testing"
date: "`r Sys.Date()`"
menu : "main"
weight: 2
chapter : false
pre : " <b> 6.3.2 </b> "
---

### 3.2 Network ACL Testing

Network ACLs (NACLs) act as a stateless firewall at the subnet level, providing an additional layer of security for your VPC. Testing NACLs is essential to ensure they are enforcing inbound and outbound traffic rules as designed, especially in isolating different environments (e.g., Production and Development) and controlling data flow between subnets. This helps prevent unauthorized access and limits the scope of security incidents.

#### Manually Test Network ACLs

To test Network ACLs, you will run the following commands from your **Bastion Host**. Replace placeholder IP addresses with the actual IPs of your instances.

**Note:** Ensure the corresponding SSH key (`.pem` file) has been copied to the Bastion Host and has appropriate permissions (`chmod 400`).

**1. Test Production and Development isolation:**

*   **Command:**
    ```bash
    ssh -i ~/.ssh/your-key.pem ec2-user@<IP_Production_Instance> "timeout 5 nc -zv <IP_Development_Instance> 22"
    ```
![](/images/6.testing-monitoring/hinh-31.png)
    *(Run this command from the Bastion Host. It will SSH into the Production Instance and from there attempt to connect to the Development Instance via port 22. The expected result is the command hanging or timing out, indicating the connection is blocked.)*

**2. Test Hub can reach Production:**

*   **Command:**
    ```bash
    timeout 5 nc -zv <IP_Production_Instance> 22
    ```
![](/images/6.testing-monitoring/hinh-32.png)
    *(Run this command from the Bastion Host. The expected result is a successful connection.)*

**3. Test Hub can reach Development:**

*   **Command:**
    ```bash
    timeout 5 nc -zv <IP_Development_Instance> 22
    ```
![](/images/6.testing-monitoring/hinh-33.png)
    *(Run this command from the Bastion Host. The expected result is a successful connection.)*
