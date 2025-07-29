---
title: "Network ACL Implementation"
menu : "main"
weight: 4
chapter : false
pre : " <b> 5.4 </b> "
---

Network ACLs (NACLs) are an optional layer of security for your VPC that acts as a firewall for controlling traffic in and out of one or more subnets.

### 4.1 Production Network ACL
Configured tightly to only allow necessary traffic and deny all communication from the Development environment.
```
Name: Production-NACL
VPC: Production-VPC

Inbound Rules:
Rule #  | Type        | Protocol | Port Range | Source      | Allow/Deny
100     | HTTP        | TCP      | 80         | 0.0.0.0/0   | ALLOW
110     | HTTPS       | TCP      | 443        | 0.0.0.0/0   | ALLOW
120     | SSH         | TCP      | 22         | 10.0.0.0/16 | ALLOW
130     | MySQL       | TCP      | 3306       | 10.1.0.0/16 | ALLOW
140     | Custom TCP  | TCP      | 8080       | 10.1.0.0/16 | ALLOW
150     | Custom TCP  | TCP      | 1024-65535 | 0.0.0.0/0   | ALLOW
200     | All Traffic | All      | All        | 10.2.0.0/16 | DENY

Outbound Rules:
Rule #  | Type        | Protocol | Port Range | Destination | Allow/Deny
100     | All Traffic | All      | All        | 0.0.0.0/0   | ALLOW
```
![](/images/5.routing-security/hinh-23.png)
![](/images/5.routing-security/hinh-24.png)

### 4.2 Development Network ACL
Allows internal and Hub communication, but denies any connection attempts from the Production environment.
```
Name: Development-NACL
VPC: Development-VPC

Inbound Rules:
Rule #  | Type        | Protocol | Port Range | Source      | Allow/Deny
100     | All Traffic | All      | All        | 10.0.0.0/16 | ALLOW
110     | All Traffic | All      | All        | 10.2.0.0/16 | ALLOW
120     | Ephemeral   | TCP      | 1024-65535 | 0.0.0.0/0   | ALLOW
200     | All Traffic | All      | All        | 10.1.0.0/16 | DENY

Outbound Rules:
Rule #  | Type        | Protocol | Port Range | Destination | Allow/Deny
100     | All Traffic | All      | All        | 0.0.0.0/0   | ALLOW
```
![](/images/5.routing-security/hinh-25.png)
![](/images/5.routing-security/hinh-26.png)
![](/images/5.routing-security/hinh-27.png)

### 4.3 Hub Network ACL
Allows traffic from the Spokes and the internet, but has a specific rule for administrative access (SSH) from a designated public IP address.
```
Name: Hub-NACL
VPC: Hub-VPC

Inbound Rules:
Rule #  | Type        | Protocol | Port Range | Source           | Allow/Deny
100     | All Traffic | All      | All        | 10.1.0.0/16 | ALLOW
110     | All Traffic | All      | All        | 10.2.0.0/16 | ALLOW
120     | HTTP        | TCP      | 80         | 0.0.0.0/0   | ALLOW
130     | HTTPS       | TCP      | 443        | 0.0.0.0/0   | ALLOW
140     | SSH         | TCP      | 22         | 66.249.66.161/32 | ALLOW
150     | Custom TCP  | TCP      | 1024-65535 | 0.0.0.0/0   | ALLOW

Outbound Rules:
Rule #  | Type        | Protocol | Port Range | Destination | Allow/Deny
100     | All Traffic | All      | All        | 0.0.0.0/0   | ALLOW
```
![](/images/5.routing-security/hinh-28.png)
![](/images/5.routing-security/hinh-29.png)
![](/images/5.routing-security/hinh-30.png)