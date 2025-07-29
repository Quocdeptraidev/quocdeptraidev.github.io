---
title: "Bandwidth Testing"
date: "`r Sys.Date()`"
menu : "main"
weight: 2
chapter : false
pre : " <b> 6.2.2 </b> "
---

### 2.2 Bandwidth Testing

This section uses `iperf3` to measure network throughput between different points. `iperf3` operates in a client-server model.

**Important Notes:**
*   **Install `iperf3`:** Ensure `iperf3` is installed on all instances participating in the test (e.g., Bastion Host, Production instance, Development instance).
    # On Amazon Linux/CentOS/RHEL
```bash
sudo yum update -y
sudo yum install -y iperf3
```
![](/images/6.testing-monitoring/hinh-18.png)
# On Ubuntu/Debian
```bash
sudo apt update
sudo apt install -y iperf3
```
*   **Security Group Configuration:** Ensure the Security Group of the instance acting as the server (`iperf3 -s`) allows TCP traffic on port **5201** from the instance acting as the client (`iperf3 -c`).
*   **Stop `iperf3` server:** After testing, remember to stop `iperf3` server processes using `sudo killall iperf3` or `ps aux | grep iperf3` then `sudo kill <PID>`.

#### Tests and Instructions:

1.  **Start `iperf3` Server on the target instance:**
    *   **SSH into the target instance** (e.g., Production instance `10.1.1.10`, Development instance `10.2.1.10`).
    *   Run command: `iperf3 -s -D` (run server in daemon mode).

![](/images/6.testing-monitoring/hinh-19.png)
![](/images/6.testing-monitoring/hinh-20.png)
2.  **Test bandwidth from Hub to Production:**
    *   **From Bastion Host:**
        ```bash
        iperf3 -c <IP_instance_Production> -t 30 -P 4
        ```
![](/images/6.testing-monitoring/hinh-21.png)
    *   **Expected Result:** Displays throughput (e.g., Gbits/sec, Mbits/sec). If the connection fails (0.00 Bytes), recheck the `iperf3` server and Security Group.

3.  **Test bandwidth from Production to Development (if allowed):**
    *   **Start `iperf3` Server on the Development instance.**
    *   **From Bastion Host, SSH into the Production instance and run the client command:**
        ```bash
        ssh -i ~/.ssh/Prod-Test-Instance-Key.pem ec2-user@<IP_instance_Production> "iperf3 -c <IP_instance_Development> -t 30"
        ```
![](/images/6.testing-monitoring/hinh-22.png)
![](/images/6.testing-monitoring/hinh-23.png)
    *   **Expected Result:** Displays throughput. If there is isolation between Prod and Dev, this command may fail (timeout/connection refused), which is the expected result for security.

4.  **Test bandwidth to the internet (via NAT Gateway):**
    *   **From Bastion Host:**
        ```bash
        iperf3 -c iperf.he.net -t 30
        ```
![](/images/6.testing-monitoring/hinh-24.png)
    *   **Expected Result:** Displays throughput to the Internet. (Note: `iperf.he.net` is a public server).
