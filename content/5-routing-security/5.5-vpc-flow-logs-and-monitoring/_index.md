---
title: "VPC Flow Logs and Monitoring"
menu : "main"
weight: 5
chapter : false
pre : " <b> 5.5 </b> "
---

Enabling Flow Logs is essential for gaining detailed visibility into network traffic, which aids in troubleshooting and security investigations.

### 5.1 Enable Comprehensive Flow Logs

We will enable flow logs for all VPCs to capture information about the IP traffic going to and from network interfaces.

#### Hub VPC Flow Logs
```bash
aws ec2 create-flow-logs \
    --resource-type VPC \
    --resource-ids vpc-hub-xxxxxxxxx \
    --traffic-type ALL \
    --log-destination-type cloud-watch-logs \
    --log-group-name /aws/vpc/hub/flowlogs \
    --deliver-logs-permission-arn arn:aws:iam::ACCOUNT:role/flowlogsRole
```
![](/images/5.routing-security/hinh-32.png)

#### Production VPC Flow Logs
```bash
aws ec2 create-flow-logs \
    --resource-type VPC \
    --resource-ids vpc-prod-xxxxxxxxx \
    --traffic-type ALL \
    --log-destination-type cloud-watch-logs \
    --log-group-name /aws/vpc/production/flowlogs \
    --deliver-logs-permission-arn arn:aws:iam::ACCOUNT:role/flowlogsRole
```
![](/images/5.routing-security/hinh-33.png)

#### Development VPC Flow Logs
```bash
aws ec2 create-flow-logs \
    --resource-type VPC \
    --resource-ids vpc-dev-xxxxxxxxx \
    --traffic-type ALL \
    --log-destination-type cloud-watch-logs \
    --log-group-name /aws/vpc/development/flowlogs \
    --deliver-logs-permission-arn arn:aws:iam::ACCOUNT:role/flowlogsRole
```
![](/images/5.routing-security/hinh-35.png)

### 5.2 Transit Gateway Flow Logs

Enable flow logs for the Transit Gateway itself to get a holistic view of all traffic passing through the central network.

```bash
aws ec2 create-transit-gateway-flow-logs \
    --transit-gateway-id tgw-xxxxxxxxx \
    --traffic-type ALL \
    --log-destination-type cloud-watch-logs \
    --log-group-name /aws/transitgateway/flowlogs
```