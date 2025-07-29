---
title : "Workshop Advanced VPC Network Architecture với Transit Gateway"
date: 2024-07-11
weight : 1 
chapter : false
---

# Workshop Advanced VPC Network Architecture với Transit Gateway

### Tổng quan

Trong workshop này, bạn sẽ học cách thiết kế và triển khai kiến trúc mạng multi-VPC tiên tiến sử dụng AWS Transit Gateway theo mô hình hub-and-spoke. Workshop sẽ hướng dẫn bạn xây dựng một hệ thống mạng có khả năng mở rộng, bảo mật và hiệu quả cho môi trường doanh nghiệp.

![VPC Architecture](/images/arc_drawio.png)


### Mục tiêu Workshop

- **Thiết kế kiến trúc mạng enterprise-grade** với AWS Transit Gateway
- **Triển khai mô hình hub-and-spoke** để tối ưu hóa kết nối
- **Cấu hình bảo mật multi-layer** với Security Groups và NACLs
- **Tối ưu hóa chi phí** thông qua shared services
- **Monitoring và troubleshooting** network performance

### Thành phần chính

#### 1. Hub VPC (Central Hub)
- **Shared Services**: NAT Gateway, DNS, Active Directory
- **Security Services**: Firewall, IDS/IPS, Security monitoring
- **Management Services**: Bastion hosts, monitoring tools
- **Connectivity**: VPN Gateway, Direct Connect Gateway

#### 2. Spoke VPCs (Branches)
- **Production VPC**: Production environment với high availability
- **Development VPC**: Development và testing environment
- **Staging VPC**: Pre-production environment
- **DMZ VPC**: Demilitarized zone cho public-facing services

#### 3. Transit Gateway
- **Route Tables**: Control traffic flow giữa VPCs
- **Attachments**: Connections tới VPC, VPN, Direct Connect
- **Route Propagation**: Automatic route learning và distribution

### Nội dung Workshop

 1. [Giới thiệu và Kiến trúc](1-Introduce/)
 2. [Thiết lập Transit Gateway](2-transit-gateway/)
 3. [Tổng quan Hub VPC](3-hub-vpc/)
 4. [Tạo Spoke VPCs (Production & Development)](4-spoke-vpcs/)
 5. [Cấu hình Routing và Security](5-routing-security/)
 6. [Testing và Monitoring](6-testing-monitoring/)
 7. [Dọn dẹp tài nguyên](7-cleanup/)

### Lợi ích Kiến trúc

#### 1. Connection Optimization
- Giảm từ O(n²) xuống O(n) connections
- Simplified network topology
- Centralized routing control

#### 2. Enhanced Security
- **Network Segmentation**: Environment isolation
- **Centralized Security**: Apply security policies từ hub
- **Traffic Inspection**: Centralized traffic control và monitoring

#### 3. Efficient Management
- **Single Point of Control**: Manage routing từ một điểm
- **Shared Services**: Optimize costs và resources
- **Scalability**: Easy addition/removal của spoke VPCs

#### 4. Cost Optimization
- Share NAT Gateway và common services
- Reduce data transfer costs
- Optimize bandwidth utilization

### Thời gian ước tính
- **Tổng thời gian**: 6-8 giờ
- **Level**: Intermediate to Advanced
- **Chi phí ước tính**: ~$15-20 cho workshop hoàn chỉnh

### Yêu cầu trước khi bắt đầu

#### AWS Account
- AWS Account với admin permissions
- AWS CLI configured
- Region: Asia Pacific (Singapore) - ap-southeast-1

#### Kiến thức cần thiết
- Hiểu biết cơ bản về AWS VPC
- Kinh nghiệm với EC2 và networking
- Familiarity với AWS Console

#### Tools cần thiết
- AWS CLI
- SSH client
- Text editor
- Web browser

### Chi phí ước tính

| Service | Cost/Month | Workshop (4 days) |
|---------|------------|-------------------|
| Transit Gateway | $36.00 | $4.80 |
| NAT Gateway | $45.00 | $6.00 |
| VPC Endpoints | $7.20 | $0.96 |
| EC2 Instances | $7.50 | $1.00 |
| **Total** | **$95.70** | **~$12.76** |

### ⚠️ Lưu ý quan trọng

- Workshop sẽ tạo ra chi phí AWS thực tế
- Theo dõi chi phí qua AWS Cost Explorer
- **Bắt buộc** thực hiện cleanup sau khi hoàn thành
- Không sử dụng production account
- Sử dụng IAM user với permissions tối thiểu

### Expected Outcomes

Sau khi hoàn thành workshop, bạn sẽ có:

1. Complete network architecture với detailed documentation
2. Security framework ensuring multi-layered security
3. Performance benchmarks và optimization guidelines
4. Cost analysis với recommendations
5. Operational procedures cho troubleshooting và DR
6. Best practices cho enterprise network design


> ### 🚀 **Chúc bạn học tập hiệu quả với Advanced VPC Network Architecture Workshop!** 🌐
