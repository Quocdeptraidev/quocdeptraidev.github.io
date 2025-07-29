---
title: "Advanced Security Group Configuration"
menu : "main"
weight: 3
chapter : false
pre : " <b> 5.3 </b> "
---

Security Groups act as a virtual firewall for instances, controlling inbound and outbound traffic. We will configure them following the principle of least privilege.

### 3.1 Centralized Security Group Management

#### Hub Security Group
This security group allows shared services in the Hub VPC to communicate with the Spokes.
```
Name: Hub-Shared-Services-SG
Description: Security group for shared services in the Hub

Inbound Rules:
- Type: HTTPS (443), Source: 10.1.0.0/16, 10.2.0.0/16
- Type: DNS (53), Source: 10.1.0.0/16, 10.2.0.0/16
- Type: NTP (123), Source: 10.1.0.0/16, 10.2.0.0/16

Outbound Rules:
- Type: All Traffic, Destination: 0.0.0.0/0
```
![](/images/5.routing-security/hinh-9.png)
![](/images/5.routing-security/hinh-10.png)

#### Cross-VPC Communication Security Group
Allows controlled communication between specific applications in different VPCs.
```
Name: Cross-VPC-Communication-SG
Description: Allows specific cross-VPC communication

Inbound Rules:
- Type: Custom TCP (8080), Source: sg-xxxxxxxxx (Specific application SG)
- Type: Custom TCP (5432), Source: sg-xxxxxxxxx (Database client SG)
```
![](/images/5.routing-security/hinh-11.png)
![](/images/5.routing-security/hinh-12.png)
![](/images/5.routing-security/hinh-13.png)

### 3.2 Micro-segmentation

We create separate security groups for each application tier to limit the attack surface.

#### Web Tier Security Group
```
Name: Prod-Web-Tier-SG
Inbound: HTTP/HTTPS from ALB, SSH from Bastion
Outbound: Custom TCP (8080) to App Tier
```
![](/images/5.routing-security/hinh-14.png)
![](/images/5.routing-security/hinh-15.png)
![](/images/5.routing-security/hinh-16.png)

#### App Tier Security Group
```
Name: Prod-App-Tier-SG
Inbound: Custom TCP (8080) from Web Tier, SSH from Bastion
Outbound: MySQL/Aurora (3306) to DB Tier
```
![](/images/5.routing-security/hinh-17.png)
![](/images/5.routing-security/hinh-18.png)
![](/images/5.routing-security/hinh-19.png)

#### DB Tier Security Group
```
Name: Prod-DB-Tier-SG
Inbound: MySQL/Aurora (3306) from App Tier
Outbound: HTTPS (443) for updates
```
![](/images/5.routing-security/hinh-20.png)
![](/images/5.routing-security/hinh-21.png)
![](/images/5.routing-security/hinh-22.png)