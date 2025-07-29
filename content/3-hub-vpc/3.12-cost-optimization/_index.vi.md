---
title: "Tối Ưu Hóa Chi Phí"
date :  "`r Sys.Date()`" 
menu : "main"
weight : 12
chapter : false
pre : " <b> 3.12 </b> "
---

## Tối Ưu Hóa Chi Phí

### Current Costs
- **NAT Gateway**: $45/month × 2 = $90/month
- **VPC Endpoints**: ~$7.20/month per endpoint
- **Elastic IPs**: $3.65/month × 2 = $7.30/month

### Optimization Tips
1. **Consolidate NAT Gateways** nếu không cần HA
2. **Use VPC Endpoints** để giảm NAT Gateway traffic
3. **Monitor data transfer** qua CloudWatch
