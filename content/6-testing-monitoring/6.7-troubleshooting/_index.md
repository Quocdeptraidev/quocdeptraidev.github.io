---
title: "Common Troubleshooting"
date: "`r Sys.Date()`"
menu : "main"
weight: 7
chapter : false
pre : " <b> 6.7 </b> "
---

## Common Troubleshooting

{{% notice info %}}
During the operation of a hub-and-spoke network architecture, encountering issues is inevitable. This section provides guidance on how to troubleshoot common problems related to high latency, connectivity issues, and performance degradation. Understanding the root causes and troubleshooting steps will help you quickly resolve issues and maintain stable system operation.
{{% /notice %}}

### 1. High Latency
- Check Transit Gateway routing tables
- Verify instances are in the correct AZs
- Review security group rules
- Check for network congestion

### 2. Connectivity Issues
- Verify routing table configurations
- Check security group rules
- Validate Network ACL settings
- Confirm Transit Gateway attachments

### 3. Performance Degradation
- Monitor CloudWatch metrics
- Check resource limitations
- Review network utilization
- Validate instance types
