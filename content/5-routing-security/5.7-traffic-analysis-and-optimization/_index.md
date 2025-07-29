---
title: "Traffic Analysis and Optimization"
menu : "main"
weight: 7
chapter : false
pre : " <b> 5.7 </b> "
---

Use AWS tools to analyze flow logs, which helps in optimizing performance and enhancing security.

### 7.1 Flow Log Analysis

Use **CloudWatch Logs Insights** to run interactive queries on your flow log data.

#### Query for Top Talkers
Helps identify applications or servers with unusual bandwidth consumption.
```sql
fields @timestamp, srcaddr, dstaddr, bytes
| filter action = "ACCEPT"
| stats sum(bytes) as total_bytes by srcaddr, dstaddr
| sort total_bytes desc
| limit 20
```
![](/images/5.routing-security/hinh-61.png)
![](/images/5.routing-security/hinh-62.png)
![](/images/5.routing-security/hinh-63.png)

#### Query for Rejected Traffic
Crucial for detecting unauthorized access attempts or misconfigurations.
```sql
fields @timestamp, srcaddr, dstaddr, srcport, dstport, protocol
| filter action = "REJECT"
| stats count() as rejected_count by srcaddr, dstaddr, dstport
| sort rejected_count desc
| limit 10
```
![](/images/5.routing-security/hinh-57.png)
![](/images/5.routing-security/hinh-58.png)
![](/images/5.routing-security/hinh-59.png)

### 7.2 Performance Optimization

#### Route Table Optimization
Regularly review and clean up unnecessary routes in the Transit Gateway route tables.
```bash
aws ec2 search-transit-gateway-routes \
    --transit-gateway-route-table-id tgw-rtb-xxxxxxxxx \
    --filters "Name=state,Values=active"
```
![](/images/5.routing-security/hinh-64.png)

#### Bandwidth Monitoring
Use CloudWatch to monitor the bandwidth usage of the Transit Gateway and identify potential bottlenecks.
```bash
aws cloudwatch get-metric-statistics \
    --namespace AWS/TransitGateway \
    --metric-name BytesIn \
    --dimensions Name=TransitGateway,Value=tgw-xxxxxxxxx \
    --start-time 2024-07-10T00:00:00Z \
    --end-time 2024-07-11T00:00:00Z \
    --period 3600 \
    --statistics Sum
```
![](/images/5.routing-security/hinh-65.png)
![](/images/5.routing-security/hinh-66.png)