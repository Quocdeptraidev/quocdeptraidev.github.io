---
title: "Security Monitoring and Alerting"
menu : "main"
weight: 6
chapter : false
pre : " <b> 5.6 </b> "
---

Setting up proactive monitoring and alerting allows us to detect and respond quickly to potential security events.

### 6.1 CloudWatch Alarms

We create alarms based on Transit Gateway metrics to be notified of unusual activities.

#### Alert on Abnormal Traffic Patterns
```bash
aws cloudwatch put-metric-alarm \
    --alarm-name "High-Cross-VPC-Traffic" \
    --metric-name BytesIn \
    --namespace AWS/TransitGateway \
    --statistic Sum \
    --period 300 \
    --threshold 1000000000 \
    --comparison-operator GreaterThanThreshold
```
![](/images/5.routing-security/hinh-37.png)
![](/images/5.routing-security/hinh-38.png)

#### Alert on Failed Connection Attempts
```bash
aws cloudwatch put-metric-alarm \
    --alarm-name "High-Rejected-Connections" \
    --metric-name PacketDropCount \
    --namespace AWS/TransitGateway \
    --statistic Sum \
    --period 300 \
    --threshold 1000 \
    --comparison-operator GreaterThanThreshold
```
![](/images/5.routing-security/hinh-39.png)
![](/images/5.routing-security/hinh-40.png)

### 6.2 Custom Metrics

Use a Lambda function to collect custom metrics, such as the number of rules in security groups, and send them to CloudWatch for tracking.

```python
# Lambda function to count rules in Security Groups
import boto3

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')
    cloudwatch = boto3.client('cloudwatch')
    # ... logic to get SGs, count rules, and put metrics
```
![](/images/5.routing-security/hinh-41.png)
![](/images/5.routing-security/hinh-42.png)
![](/images/5.routing-security/hinh-43.png)
![](/images/5.routing-security/hinh-44.png)
![](/images/5.routing-security/hinh-45.png)
![](/images/5.routing-security/hinh-46.png)
![](/images/5.routing-security/hinh-47.png)
![](/images/5.routing-security/hinh-48.png)
![](/images/5.routing-security/hinh-49.png)
![](/images/5.routing-security/hinh-50.png)
![](/images/5.routing-security/hinh-51.png)
![](/images/5.routing-security/hinh-52.png)
![](/images/5.routing-security/hinh-53.png)
![](/images/5.routing-security/hinh-54.png)

### 6.3 Troubleshooting Lambda Deployment

If the Lambda function times out, you need to increase the "Timeout" value in the function's configuration, for example, from 3 seconds to 30 seconds.
![](/images/5.routing-security/hinh-55.png)
![](/images/5.routing-security/hinh-56.png)

### 6.4 Threat Monitoring with Amazon GuardDuty

Enabling **Amazon GuardDuty** is a best practice for intelligent threat detection. GuardDuty automatically analyzes AWS CloudTrail logs, VPC Flow Logs, and DNS logs to identify malicious or unauthorized activities.
