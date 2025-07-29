---
title: "Xử Lý Sự Cố (Troubleshooting)"
date :  "`r Sys.Date()`" 
menu : "main"
weight : 13
chapter : false
pre : " <b> 3.13 </b> "
---


## Xử Lý Sự Cố (Troubleshooting)

### Common Issues

1. **Cannot reach internet from private subnets**
   - Check NAT Gateway status
   - Verify route table configuration
   - Check security group rules

2. **VPC Endpoints not working**
   - Verify endpoint policy
   - Check security group rules
   - Ensure DNS resolution is enabled

3. **Transit Gateway attachment failed**
   - Check subnet selection
   - Verify Transit Gateway status
   - Check IAM permissions
