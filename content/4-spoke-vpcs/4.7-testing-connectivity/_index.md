---
title : "Testing Connectivity"
date :  "2025-07-13" 
menu : "main"
weight : 7
chapter : false
pre : " <b> 4.7 </b> "
---

## Step 9: Testing Connectivity

### 9.1 Test from Bastion Host to Spoke Instances

1.  **Connect to the Bastion Host from your local machine via SSH:**
    ```bash
    ssh -i "path_to_your_bastion_key/Hub-Bastion-Host-Key.pem" ec2-user@<Public_IP_of_Bastion_Host>
    ```

2.  **Copy the Spoke Instance's Key Pair to the Bastion Host (if different from the Bastion Host's Key Pair):**
    *   **From your local machine's terminal:**
        ```bash
        scp -i "path_to_your_bastion_key/Hub-Bastion-Host-Key.pem" "path_to_your_spoke_key/Spoke-Test-Instance-Key.pem" ec2-user@<Public_IP_of_Bastion_Host>:~/.ssh/
        ```
![](/images/4.spoke-vpcs/hinh-70.png)
3.  **Set the correct permissions for the Key Pair file on the Bastion Host:**
    *   **From the Bastion Host's terminal:**
        ```bash
        chmod 400 ~/.ssh/Spoke-Test-Instance-Key.pem
        ```
4.  **Test connectivity (Ping and SSH) to the Spoke instances from the Bastion Host:**
    *   **From the Bastion Host's terminal:**
        ```bash
        # Test Production instance
        ping <Private_IP_of_Prod-Test-Instance>
        ```
        ![](/images/4.spoke-vpcs/hinh-69.png)
        ```bash
        ssh -i ~/.ssh/Spoke-Test-Instance-Key.pem ec2-user@<Private_IP_of_Prod-Test-Instance>
        ```
        ![](/images/4.spoke-vpcs/hinh-70.png)
        ```bash
        # Test Development instance
        ping <Private_IP_of_Dev-Test-Instance>
        ```
        ![](/images/4.spoke-vpcs/hinh-71.png)
        ```bash
        ssh -i ~/.ssh/Spoke-Test-Instance-Key.pem ec2-user@<Private_IP_of_Dev-Test-Instance>
        ```
        ![](/images/4.spoke-vpcs/hinh-72.png)

### 9.2 Test Internet Connectivity from Spoke VPCs

After successfully SSHing into `Prod-Test-Instance`:

```bash
# Test internet connectivity
ping google.com
curl -I https://aws.amazon.com
# Check route
ip route show
```
![](/images/4.spoke-vpcs/hinh-73.png)
![](/images/4.spoke-vpcs/hinh-74.png)
![](/images/4.spoke-vpcs/hinh-75.png)

After successfully SSHing into `Dev-Test-Instance`:
```bash
# Test internet connectivity
ping google.com
curl -I https://aws.amazon.com
# Check route
ip route show
```
![](/images/4.spoke-vpcs/hinh-76.png)
![](/images/4.spoke-vpcs/hinh-77.png)
![](/images/4.spoke-vpcs/hinh-78.png)
### 9.3 Test Inter-VPC Communication

```bash
# From Production instance
ping <Private_IP_of_Dev-Test-Instance>

# From Development instance
ping <Private_IP_of_Prod-Test-Instance>
```