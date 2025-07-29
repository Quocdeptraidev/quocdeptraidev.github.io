---
title: "VPC Flow Log Analysis"
date: "`r Sys.Date()`"
menu : "main"
weight: 3
chapter : false
pre : " <b> 6.3.3 </b> "
---

### 3.3 VPC Flow Log Analysis

#### Explanation:
VPC Flow Logs record all IP traffic going to and from network interfaces in your VPC. Analyzing these logs is a powerful security and troubleshooting tool. It helps you:
*   **Detect suspicious activity:** Look for rejected connections (`REJECT`), unfamiliar IP addresses attempting to access your resources, or unusual traffic patterns.
*   **Verify security rules:** Ensure that Security Groups and Network ACLs are blocking or allowing traffic as expected.
*   **Troubleshoot connectivity issues:** Identify the root cause of connectivity problems by examining details of dropped packets or unwanted flows.
*   **Monitor network performance:** Analyze the amount of data transferred between components to detect bottlenecks or unusual traffic patterns.

Analyzing VPC flow logs from separate log groups for Development, Hub, and Production is extremely important because it allows you to:
*   **Monitor in detail by environment:** Easily focus on traffic and security events specific to each environment without being cluttered by data from other environments.
*   **More effective troubleshooting:** When there are connectivity or security issues, you can quickly narrow down the problem to a specific environment and analyze relevant logs.
*   **Ensure compliance and auditing:** Provides detailed auditing capabilities for network traffic in each environment, helping to meet compliance requirements.
*   **Detect anomalies:** Easily identify unusual traffic patterns or unauthorized access attempts in each separate area of the network architecture.

#### Analyzing Security Events (Manual)

To analyze VPC flow logs, you will use the AWS CLI to query CloudWatch Logs Insights.

**Important Note:**
*   You need AWS CLI permissions configured on your computer or Bastion Host to access CloudWatch Logs.
*   You can adjust `1 hour ago` to change the query time range.
*   You have the following VPC flow log groups: `/aws/vpc/development/flowlogs`, `/aws/vpc/hub/flowlogs`, `/aws/vpc/production/flowlogs`. You will need to run the queries below for each log group to get a comprehensive view.

**1. Query rejected connections (potential security events):**

This command will search for rejected connections in your VPC flow logs over the last hour, grouped by source IP address, destination IP address, and destination port, then sorted by the number of rejections.

*   **For Development VPC, Hub VPC, and Production VPC:**
    ```bash
    aws logs start-query \
        --log-group-name "/aws/vpc/development/flowlogs" "/aws/vpc/hub/flowlogs" "/aws/vpc/production/flowlogs" \
        --start-time $(date -d '1 hour ago' +%s) \
        --end-time $(date +%s) \
        --query-string 'fields @timestamp, srcaddr, dstaddr, srcport, dstport, protocol, action
        | filter action = "REJECT"
        | stats count() as rejected_count by srcaddr, dstaddr, dstport
        | sort rejected_count desc
        | limit 20'
    ```
![](/images/6.testing-monitoring/hinh-34.png)
*   **Expected Result:** Each command will return a table containing `queryId`. You then need to use `aws logs get-query-results --query-id <queryId>` to view the actual results. The result will be a table listing the source IP addresses, destination IP addresses, and destination ports that were rejected, along with the number of rejections. If no connections were rejected during that time, the table will be empty.

```