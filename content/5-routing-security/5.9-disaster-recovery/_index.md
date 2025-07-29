---
title: "Disaster Recovery and Business Continuity"
menu : "main"
weight: 9
chapter : false
pre : " <b> 5.9 </b> "
---

Planning for resilience is an integral part of a robust architecture.

### 9.1 Verify Multi-AZ Deployment

Ensure that critical resources are deployed across multiple Availability Zones to increase high availability.

```bash
# Verify that subnets are deployed across multiple AZs
aws ec2 describe-subnets \
    --filters "Name=vpc-id,Values=vpc-xxxxxxxxx" \
    --query 'Subnets[*].[SubnetId,AvailabilityZone,CidrBlock]' \
    --output table
```
![](/images/5.routing-security/hinh-69.png)
![](/images/5.routing-security/hinh-70.png)
![](/images/5.routing-security/hinh-71.png)

### 9.2 Backup and Recovery Procedures

Regularly back up your network configuration to be able to quickly recover in case of an incident.

#### Backup Transit Gateway Configuration

Export the Transit Gateway configuration and its route tables to JSON files.

```bash
# Export Transit Gateway configuration
aws ec2 describe-transit-gateways \
    --transit-gateway-ids tgw-xxxxxxxxx > tgw-backup.json

# Export Transit Gateway route tables
aws ec2 describe-transit-gateway-route-tables \
    --filters "Name=transit-gateway-id,Values=tgw-xxxxxxxxx" > tgw-routes-backup.json
```
![](/images/5.routing-security/hinh-72.png)