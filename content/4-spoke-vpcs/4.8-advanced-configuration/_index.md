---
title : "Advanced Configuration"
date :  "2025-07-13" 
menu : "main"
weight : 8
chapter : false
pre : " <b> 4.8 </b> "
---

## Step 10: Network ACLs (Optional)

### 10.1 Production Network ACL

```
Name: Prod-NACL
VPC: Production-VPC

Inbound Rules:
100 - HTTP (80) - 0.0.0.0/0 - ALLOW
110 - HTTPS (443) - 0.0.0.0/0 - ALLOW
120 - SSH (22) - 10.0.0.0/16 - ALLOW
130 - Ephemeral (1024-65535) - 0.0.0.0/0 - ALLOW

Outbound Rules:
100 - All Traffic - 0.0.0.0/0 - ALLOW
```

### 10.2 Development Network ACL

```
Name: Dev-NACL
VPC: Development-VPC

Inbound Rules:
100 - All Traffic - 10.0.0.0/16 - ALLOW
110 - Ephemeral (1024-65535) - 0.0.0.0/0 - ALLOW

Outbound Rules:
100 - All Traffic - 0.0.0.0/0 - ALLOW
```

## Cost Optimization

### Current Additional Costs
- **Transit Gateway Attachments**: $36/month × 2 = $72/month
- **Data Processing**: $0.02/GB processed
- **EC2 Instances**: $7.50/month × 2 = $15/month

### Optimization Tips
1. **Right-size instances** based on actual usage
2. **Use Spot Instances** for development
3. **Schedule instances** to run only during business hours
4. **Monitor data transfer** costs

## Troubleshooting

### Common Issues

1. **Cannot reach spoke instances from bastion**
   - Check Transit Gateway route tables
   - Verify security group rules
   - Check VPC route tables

2. **No internet connectivity from spoke VPCs**
   - Verify default route points to Transit Gateway
   - Check Hub VPC NAT Gateway status
   - Verify Transit Gateway routing

3. **Inter-VPC communication not working**
   - Check Transit Gateway route table associations
   - Verify security group rules allow traffic
   - Check Network ACLs

## Monitoring and Logging

### 10.1 Enable VPC Flow Logs

For each VPC:

```bash
aws ec2 create-flow-logs \
    --resource-type VPC \
    --resource-ids vpc-xxxxxxxxx \
    --traffic-type ALL \
    --log-destination-type cloud-watch-logs \
    --log-group-name /aws/vpc/flowlogs \
    --deliver-logs-permission-arn arn:aws:iam::account:role/flowlogsRole
```

### 10.2 CloudWatch Metrics

Monitor important metrics:
- **NetworkIn/NetworkOut**: Data transfer
- **NetworkPacketsIn/NetworkPacketsOut**: Packet counts
- **CPUUtilization**: Instance performance