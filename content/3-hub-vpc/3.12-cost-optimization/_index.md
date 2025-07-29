---
title: "Cost Optimization"
date :  "`r Sys.Date()`" 
menu : "main"
weight : 12
chapter : false
pre : " <b> 3.12 </b> "
---

## Cost Optimization

### Current Costs
- **NAT Gateway**: $45/month × 2 = $90/month
- **VPC Endpoints**: ~$7.20/month per endpoint
- **Elastic IPs**: $3.65/month × 2 = $7.30/month

### Optimization Tips
1. **Consolidate NAT Gateways** if HA is not required
2. **Use VPC Endpoints** to reduce NAT Gateway traffic
3. **Monitor data transfer** via CloudWatch
