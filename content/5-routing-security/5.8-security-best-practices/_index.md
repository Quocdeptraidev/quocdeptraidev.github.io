---
title: "Implementing Security Best Practices"
menu : "main"
weight: 8
chapter : false
pre : " <b> 5.8 </b> "
---

Adhering to best practices is crucial for maintaining a secure environment.

### 8.1 Principle of Least Privilege

This principle requires that only the minimum necessary permissions are granted to perform a function. We apply this by regularly reviewing and tightening the rules in our Security Groups.

#### Review and Tighten Security Groups

Use the AWS CLI to check for overly permissive security group rules, especially those that allow access from anywhere (`0.0.0.0/0`).

```bash
# Script to check for overly permissive security group rules
aws ec2 describe-security-groups \
    --query 'SecurityGroups[?IpPermissions[?IpRanges[?CidrIp==`0.0.0.0/0`]]].[GroupId,GroupName]' \
    --output table
```
![](/images/5.routing-security/hinh-67.png)
![](/images/5.routing-security/hinh-68.png)