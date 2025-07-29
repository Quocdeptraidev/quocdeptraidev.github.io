---
title : "Testing Connectivity"
date :  "2025-07-13" 
menu : "main"
weight : 7
chapter : false
pre : " <b> 4.7 </b> "
---

## Bước 9: Testing Connectivity

### 9.1 Test từ Bastion Host đến Spoke Instances

1.  **Kết nối SSH từ máy tính của bạn đến Bastion Host:**
    ```bash
    ssh -i "đường_dẫn_đến_file_key_của_bastion/Hub-Bastion-Host-Key.pem" ec2-user@<Public_IP_của_Bastion_Host>
    ```

2.  **Copy Key Pair của Spoke Instance lên Bastion Host (nếu khác Key Pair của Bastion Host):**
    *   **Từ terminal của máy tính cá nhân của bạn:**
        ```bash
        scp -i "đường_dẫn_đến_file_key_của_bastion/Hub-Bastion-Host-Key.pem" "đường_dẫn_đến_file_key_của_spoke/Spoke-Test-Instance-Key.pem" ec2-user@<Public_IP_của_Bastion_Host>:~/.ssh/
        ```
![](/images/4.spoke-vpcs/hinh-70.png)
3.  **Đặt quyền phù hợp cho file Key Pair trên Bastion Host:**
    *   **Từ terminal của Bastion Host:**
        ```bash
        chmod 400 ~/.ssh/Spoke-Test-Instance-Key.pem
        ```
4.  **Test connectivity (Ping và SSH) tới Spoke instances từ Bastion Host:**
    *   **Từ terminal của Bastion Host:**
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

### 9.2 Test Internet Connectivity từ Spoke VPCs

Sau khi SSH thành công vào `Prod-Test-Instance`:

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

Sau khi SSH thành công vào `Dev-Test-Instance`:
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