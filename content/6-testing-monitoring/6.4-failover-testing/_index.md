---
title: "AZ Failover Testing"
date: "`r Sys.Date()`"
menu : "main"
weight: 4
chapter : false
pre : " <b> 6.4 </b> "
---

### 4.1 AZ Failover Testing

#### Explanation:
Availability Zone (AZ) failover testing is a critical part of ensuring the high availability of your architecture. By simulating the failure of an instance in one AZ, you can verify that your applications can automatically switch to another AZ without significant interruption. This helps confirm that mechanisms like Auto Scaling Groups, Load Balancers, and other multi-AZ configurations are working correctly.

#### Simulating AZ Failure

**Important Notes:**
*   You need AWS CLI permissions configured to stop and start EC2 instances.
*   Replace `<Instance_ID_to_stop>` and `<Instance_ID_to_start>` with your actual EC2 instance IDs.
*   Perform this test in a non-production environment or during planned maintenance, as it will interrupt the instance.

#### Getting Private IP Addresses of Instances

To perform failover tests, you need to know the private IP addresses of instances in each AZ. Getting IPs using the AWS CLI ensures accuracy and automation, especially useful in large environments or when instances are dynamically created/deleted.

You can use the `aws ec2 describe-instances` command to get the private IP addresses of instances. You will need to know the IDs of the instances (or their tag names) to filter the results.

**How to get private IPs of instances:**

1.  **Get Hub Instance IP (AZ1a):**
    *   **If you know the Instance ID:**
        ```bash
        aws ec2 describe-instances --instance-ids <Hub_Instance_ID> --query "Reservations[].Instances[].PrivateIpAddress" --output text
        ```
        *(Replace `<Hub_Instance_ID>` with your actual Hub Instance ID)*

    *   **If you know the Instance Tag name:**
        ```bash
        aws ec2 describe-instances --filters "Name=tag:Name,Values=HubInstanceName" --query "Reservations[].Instances[].PrivateIpAddress" --output text
        ```
        *(Replace `HubInstanceName` with your actual Hub Instance Tag name)*

2.  **Get Prod Instance IP (AZ1b):**
    *   **If you know the Instance ID:**
        ```bash
        aws ec2 describe-instances --instance-ids <Prod_Instance_ID> --query "Reservations[].Instances[].PrivateIpAddress" --output text
        ```
    *   **If you know the Instance Tag name:**
        ```bash
        aws ec2 describe-instances --filters "Name=tag:Name,Values=ProdInstanceName" --query "Reservations[].Instances[].PrivateIpAddress" --output text
        ```

3.  **Get Dev Instance IP (AZ1b):**
    *   **If you know the Instance ID:**
        ```bash
        aws ec2 describe-instances --instance-ids <Dev_Instance_ID> --query "Reservations[].Instances[].PrivateIpAddress" --output text
        ```
    *   **If you know the Instance Tag name:**
        ```bash
        aws ec2 describe-instances --filters "Name=tag:Name,Values=DevInstanceName" --query "Reservations[].Instances[].PrivateIpAddress" --output text
        ```

Once you have these private IP addresses, you can use them in the `ping` commands in Step 1 of the **Simulating AZ Failure** section.

**1. Test connectivity to both AZs:**

Before simulating a failure, verify that you can connect to instances in both AZs.

*   **Test connectivity to AZ-1a (Hub Instance):**
    ```bash
    ping -c 3 <IP_Hub_Instance_AZ1a>
    ```
![](/images/6.testing-monitoring/hinh-35.png)
*   **Test connectivity to AZ-1b (Prod Instance):**
    ```bash
    ping -c 3 <IP_Prod_Instance_AZ1b>
    ```
![](/images/6.testing-monitoring/hinh-36.png)
*   **Test connectivity to AZ-1b (Dev Instance):**
    ```bash
    ping -c 3 <IP_Dev_Instance_AZ1b>
    ```
![](/images/6.testing-monitoring/hinh-37.png)
*   **Expected Result:** All three `ping` commands succeed (0% packet loss), indicating that the instances are active and reachable.

**2. Simulate instance failure in one AZ:**

Stop an instance in one AZ to simulate a failure.

*   **Command:**
    ```bash
    aws ec2 stop-instances --instance-ids <Instance_ID_to_stop>
    ```
![](/images/6.testing-monitoring/hinh-38.png)
    *(Replace `<Instance_ID_to_stop>` with the ID of the instance you want to stop. Example: `i-xxxxxxxxx`)*

*   **Expected Result:** The command will return information about the instance being stopped.

**3. Wait and test failover:**

Wait for a period of time for AWS failover mechanisms to work, then recheck connectivity to the other AZ.

*   **Command:**
    ```bash
    sleep 30
    ping -c 3 <IP_instance_in_other_AZ>
    ```
![](/images/6.testing-monitoring/hinh-39.png)
![](/images/6.testing-monitoring/hinh-40.png)
    *(Replace `<IP_instance_in_other_AZ>` with the IP of the instance in the other AZ that you expect traffic to fail over to.)*

*   **Expected Result:** The `ping` command to the instance in the other AZ still succeeds, indicating that traffic has successfully failed over.

**4. Restart instance (after testing):**

After completing the test, restart the stopped instance.

*   **Command:**
    ```bash
    aws ec2 start-instances --instance-ids <Instance_ID_to_start>
    ```
![](/images/6.testing-monitoring/hinh-41.png)
    *(Replace `<Instance_ID_to_start>` with the ID of the instance you stopped.)*

*   **Expected Result:** The command will return information about the instance being started.
