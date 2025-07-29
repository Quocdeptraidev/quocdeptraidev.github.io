---
title: "Testing Hub VPC"
date :  "`r Sys.Date()`" 
menu : "main"
weight : 11
chapter : false
pre : " <b> 3.11 </b> "
---

## Bước 11: Testing Hub VPC

### 11.1 Test Internet Connectivity

1. SSH vào bastion host
![](/images/3.hub-vpc/hinh-66.png)
2. Test internet connectivity:

```bash
ping google.com
curl -I https://aws.amazon.com
```
![](/images/3.hub-vpc/hinh-67.png)
### 11.2 Test VPC Endpoints

Sau khi gắn IAM Role cho Bastion Host, các lệnh `aws` CLI sẽ tự động sử dụng thông tin xác thực từ Role đó.

```bash
# Test S3 endpoint
aws s3 ls --region ap-southeast-1

# Test EC2 endpoint
aws ec2 describe-instances --region ap-southeast-1
```
![](/images/3.hub-vpc/hinh-68.png)
![](/images/3.hub-vpc/hinh-69.png)
### 11.3 Test DNS Resolution

```bash
nslookup s3.ap-southeast-1.amazonaws.com
nslookup ec2.ap-southeast-1.amazonaws.com
```
![](/images/3.hub-vpc/hinh-70.png)
