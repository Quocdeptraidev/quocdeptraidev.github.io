---
title: "Security Group Testing"
date: "`r Sys.Date()`"
menu : "main"
weight: 1
chapter : false
pre : " <b> 6.3.1 </b> "
---

### 3.1 Security Group Testing

#### Manually test blocked ports

To manually test each port from within the Production Instance (after SSHing from the Bastion Host), you can use the following commands:

**Note:** Replace `10.1.1.10` with the actual IP of the instance you are testing.

*   **Test RDP port (3389):**
    ```bash
    nc -zv 10.1.1.10 3389
    ```
![](/images/6.testing-monitoring/hinh-27.png)
*   **Test SQL Server port (1433):**
    ```bash
    nc -zv 10.1.1.10 1433
    ```
![](/images/6.testing-monitoring/hinh-28.png)
*   **Test PostgreSQL port (5432):**
    ```bash
    nc -zv 10.1.1.10 5432
    ```
![](/images/6.testing-monitoring/hinh-29.png)
*   **Test Telnet port (23):**
    ```bash
    nc -zv 10.1.1.10 23
    ```
![](/images/6.testing-monitoring/hinh-30.png)
