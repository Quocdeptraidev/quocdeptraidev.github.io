---
title : "Clean up resources"
date :  "`r Sys.Date()`" 
weight : 7
chapter : false
pre : " <b> 7. </b> "
---

In this final chapter, we will clean up all the resources created during the workshop to avoid incurring unwanted charges.

{{% notice warning %}}
IMPORTANT: Perform the cleanup steps in the correct order to avoid dependency errors. Cleanup actions cannot be undone!
{{% /notice %}}

## Cleanup Process Overview
The cleanup process should be performed in the following order:

1. **EC2 Instances and Load Balancers**
2. **VPC Endpoints**
3. **Transit Gateway Attachments**
4. **Transit Gateway Route Tables**
5. **Transit Gateway**
6. **NAT Gateways and Elastic IPs**
7. **Internet Gateways**
8. **Route Tables**
9. **Subnets**
10. **Security Groups**
11. **VPCs**
12. **CloudWatch Resources**


