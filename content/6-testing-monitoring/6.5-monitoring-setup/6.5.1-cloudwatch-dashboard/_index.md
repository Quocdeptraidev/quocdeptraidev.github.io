---
title: "CloudWatch Dashboard"
date: "`r Sys.Date()`"
menu : "main"
weight: 1
chapter : false
pre : " <b> 6.5.1 </b> "
---

### 5.1 CloudWatch Dashboard

#### Explanation:
CloudWatch Dashboards provide a centralized, comprehensive view of your resources and applications. By creating custom dashboards, you can visualize important metrics from various AWS services (such as EC2, Transit Gateway, VPC Flow Logs) on a single screen. This helps you quickly monitor performance, detect issues, and make data-driven decisions in real-time. Having a comprehensive monitoring dashboard is crucial for maintaining the stability and performance of your hub-and-spoke network architecture.

#### Creating Custom Dashboards (Manual)

YouCan create CloudWatch dashboards via the AWS console or using the AWS CLI. Below is an example of a JSON configuration for a custom dashboard, focusing on Transit Gateway traffic and Instance network traffic.

**Important Notes:**
*   Replace `tgw-xxxxxxxxx` with your actual Transit Gateway ID.
*   Replace `i-prod-xxxxxxxxx` and `i-dev-xxxxxxxxx` with your actual Production and Development instance IDs.
*   `ap-southeast-1` is an example region; replace it with your AWS region.

**1. Create a JSON file for the dashboard:**

Create a new file named `dashboard.json` on your computer (or Bastion Host) and paste the following content:
![](/images/6.testing-monitoring/hinh-44.png)
```json
{
    "widgets": [
        {
            "type": "metric",
            "properties": {
                "metrics": [
                    [ "AWS/TransitGateway", "BytesIn", "TransitGateway", "tgw-xxxxxxxxx" ],
                    [ ".", "BytesOut", ".", "." ],
                    [ ".", "PacketsIn", ".", "." ],
                    [ ".", "PacketsOut", ".", "." ]
                ],
                "period": 300,
                "stat": "Sum",
                "region": "ap-southeast-1",
                "title": "Transit Gateway Traffic"
            }
        },
        {
            "type": "metric",
            "properties": {
                "metrics": [
                    [ "AWS/EC2", "NetworkIn", "InstanceId", "i-prod-xxxxxxxxx" ],
                    [ ".", "NetworkOut", ".", "." ],
                    [ ".", "NetworkIn", ".", "i-dev-xxxxxxxxx" ],
                    [ ".", "NetworkOut", ".", "." ]
                ],
                "period": 300,
                "stat": "Average",
                "region": "ap-southeast-1",
                "title": "Instance Network Traffic"
            }
        }
    ]
}
```
![](/images/6.testing-monitoring/hinh-45.png)
**2. Deploy the Dashboard using AWS CLI:**

After creating the `dashboard.json` file, run the following command to create the dashboard in CloudWatch:

```bash
aws cloudwatch put-dashboard \
    --dashboard-name "VPC-Architecture-Monitoring" \
    --dashboard-body file://dashboard.json
```
![](/images/6.testing-monitoring/hinh-46.png)
*   **Expected Result:** The command will return a JSON response confirming the dashboard has been successfully created or updated. You can check this dashboard in the AWS CloudWatch console.

