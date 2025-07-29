---
title: "Security Configuration Testing"
menu : "main"
weight: 10
chapter : false
pre : " <b> 5.10 </b> "
---

After deploying security measures, testing is crucial to verify that your controls work as expected and no vulnerabilities are left unaddressed. This section will guide you on performing connectivity tests and security validation.

### 10.1 Connectivity Testing

Use tools like `nc` (Netcat) from the Bastion Host to check if allowed connections succeed and forbidden connections are actually blocked. This helps confirm that Security Groups and Network ACLs are functioning correctly.

**Note on IP addresses:**
*   `10.1.1.10` and `10.2.1.10` are placeholders. You need to replace them with the **private IP addresses** of your instances in the Production and Development VPCs.
*   You can find these IP addresses in the AWS Management Console, under the **EC2** service, select **Instances**, then select the desired instance and look in the **Details** (or **Description**) section.

**Explanation of connectivity test results:**

*   **Port 22 (SSH):** Should typically **succeed** when tested from the Bastion Host to internal instances. This is expected as the Bastion Host is designed to be a secure administrative access point.
*   **Port 80 (HTTP) / 443 (HTTPS):**
    *   If you test to a Web Tier instance, it might **succeed** if the instance's Security Group allows access from the Bastion Host (less common) or if you are testing to a Load Balancer.
    *   However, if it **times out** when testing directly to a Web Tier instance from the Bastion Host, this is often **correct and expected**. It indicates that the instance's Security Group only allows access from the Load Balancer, ensuring traffic flows through the designed path.
*   **Port 3389 (RDP) / 1433 (SQL Server):** These ports should typically **time out** when tested from the Bastion Host to Production instances (unless specific configurations allow very limited administrative access). Their timeout is a **sign of good security configuration**, indicating that these sensitive ports are protected from unauthorized access, enforcing the principle of least privilege.

#### Test Allowed Connections
```bash
# From the bastion host, test connectivity to each environment
ssh -i key.pem ec2-user@bastion-host
```
![](/images/5.routing-security/hinh-73.png)
# Test Production connectivity

After deployment, testing is crucial to verify that your security controls work as expected.

### 10.1 Connectivity Testing

Use tools like `nc` (Netcat) from the Bastion Host to check if allowed connections succeed and forbidden connections are actually blocked.

#### Test Allowed Connections
```bash
# From the bastion host, test SSH connection to a production instance
nc -zv 10.1.1.10 22  # Should succeed
```
![](/images/5.routing-security/hinh-73.png)

#### Test Blocked Connections
```bash
# Test RDP connection to a production instance
nc -zv 10.1.1.10 3389  # Should be blocked (timeout)

# Test connection from production to development
nc -zv 10.2.1.10 22  # Should fail if isolated
```
![](/images/5.routing-security/hinh-74.png)
![](/images/5.routing-security/hinh-75.png)

### 10.2 Security Validation

Use a checklist to perform basic penetration testing and validate security policies.

#### Checklist
- [ ] Verify that security group rules are restrictive.
- [ ] Check if NACLs block unauthorized traffic.
- [ ] Confirm cross-environment isolation.
- [ ] Validate that only authorized ports are open.
- [ ] Check if internet access is properly controlled.