# Advanced VPC Network Architecture với AWS Transit Gateway

## Tổng quan Workshop

Workshop này hướng dẫn thiết kế và triển khai kiến trúc mạng multi-VPC tiên tiến sử dụng AWS Transit Gateway theo mô hình hub-and-spoke. Bạn sẽ học cách xây dựng một hệ thống mạng có khả năng mở rộng, bảo mật và hiệu quả cho môi trường doanh nghiệp.

## Kiến trúc Workshop

```
┌─────────────────────────────────────────────────────────────┐
│                    AWS Transit Gateway                      │
│                     (Enterprise-TGW)                       │
└─────────────┬─────────────┬─────────────┬─────────────────┘
              │             │             │
    ┌─────────▼──────┐ ┌────▼─────┐ ┌─────▼──────────┐
    │   Hub VPC      │ │Prod VPC  │ │   Dev VPC      │
    │ 10.0.0.0/16    │ │10.1.0.0/16│ │ 10.2.0.0/16   │
    │                │ │          │ │                │
    │ Shared Services│ │Production │ │ Development    │
    │ - NAT Gateway  │ │Workloads  │ │ & Testing      │
    │ - DNS Server   │ │          │ │                │
    │ - VPC Endpoints│ │          │ │                │
    └────────────────┘ └──────────┘ └────────────────┘
```

## Cấu trúc Workshop

### Chương 1: [Giới thiệu và Kiến trúc](content/1-Introduce/)
- Tổng quan về hub-and-spoke architecture
- Lợi ích của Transit Gateway
- Thiết kế network topology
- Planning và requirements

### Chương 2: [Thiết lập Transit Gateway](content/2-transit-gateway/)
- Tạo AWS Transit Gateway
- Cấu hình Route Tables cho phân đoạn mạng
- Advanced routing policies
- Tài liệu hóa topology mạng

### Chương 3: [Tạo Hub VPC (Shared Services)](content/3-hub-vpc/)
- Thiết lập Hub VPC với public/private subnets
- Cấu hình Internet Gateway và NAT Gateway
- Tạo VPC Endpoints cho AWS services
- Bastion host setup

### Chương 4: [Tạo Spoke VPCs (Production & Development)](content/4-spoke-vpcs/)
- Thiết lập Production và Development VPCs
- Cấu hình Security Groups và NACLs
- Kết nối với Transit Gateway
- Multi-tier architecture implementation

### Chương 5: [Cấu hình Routing và Security](content/5-routing-security/)
- Advanced routing policies và traffic segmentation
- Multi-layer security implementation
- VPC Flow Logs và security monitoring
- Network access control và micro-segmentation

### Chương 6: [Testing và Monitoring](content/6-testing-monitoring/)
- Comprehensive network testing procedures
- Performance monitoring và optimization
- Security testing và validation
- Automated monitoring setup

### Chương 7: [Dọn dẹp tài nguyên](content/7-cleanup/)
- Proper cleanup procedures
- Resource verification
- Cost monitoring post-cleanup

## Yêu cầu trước khi bắt đầu

### AWS Account
- AWS Account với admin permissions
- AWS CLI configured (version 2.x recommended)
- Region: Asia Pacific (Singapore) - ap-southeast-1

### Kiến thức cần thiết
- Hiểu biết cơ bản về AWS VPC và networking concepts
- Kinh nghiệm với EC2, Security Groups, và Route Tables
- Familiarity với AWS Console và CLI
- Basic understanding của enterprise network architecture

### Tools cần thiết
- AWS CLI v2.x
- SSH client (PuTTY, OpenSSH)
- Text editor hoặc IDE
- Web browser (Chrome, Firefox recommended)
- Terminal/Command Prompt

## Chi phí ước tính

| Service Category | Cost/Month | Workshop (4 days) | Optimized Cost |
|------------------|------------|-------------------|----------------|
| Transit Gateway | $144.00 | $19.20 | $144.00 |
| NAT Gateways | $73.00 | $9.73 | $36.50 |
| VPC Endpoints | $21.60 | $2.88 | $21.60 |
| EC2 Instances | $38.24 | $5.10 | $26.27 |
| Monitoring | $25.00 | $3.33 | $17.50 |
| Data Transfer | $50.00 | $6.67 | $35.00 |
| **Total** | **$351.84** | **~$46.91** | **$280.87** |

*Optimized cost sau khi áp dụng cost optimization strategies từ Chương 7*

## Cách sử dụng Workshop

### 1. Clone Repository
```bash
git clone <repository-url>
cd WorkShop_Advanced_VPC_Network_Architecture_v-i_Transit_Gateway
```

### 2. Cài đặt Hugo (nếu muốn chạy local)
```bash
# macOS
brew install hugo

# Ubuntu/Debian
sudo apt-get install hugo

# Windows
choco install hugo
```

### 3. Chạy Workshop Site
```bash
hugo server -D
# Truy cập http://localhost:1313
```

### 4. Thực hiện Workshop
- Làm theo từng chương theo thứ tự
- Đọc kỹ các cảnh báo và lưu ý
- Kiểm tra chi phí thường xuyên
- **Quan trọng**: Thực hiện Chương 8 để cleanup

## Cấu trúc Files

```
├── content/
│   ├── _index.vi.md                    # Trang chủ workshop
│   ├── 1-Introduce/                    # Giới thiệu và kiến trúc
│   ├── 2-transit-gateway/              # Thiết lập Transit Gateway
│   ├── 3-hub-vpc/                      # Tạo Hub VPC
│   ├── 4-spoke-vpcs/                   # Tạo Spoke VPCs
│   ├── 5-routing-security/             # Routing và Security
│   ├── 6-testing-monitoring/           # Testing và Monitoring
│   └── 7-cleanup/                      # Cleanup resources
├── static/
│   └── images/                         # Hình ảnh minh họa
├── config.toml                         # Hugo configuration
└── README.md                           # File này
```

## Tính năng nổi bật của Workshop

### 🏗️ Enterprise Architecture
- Hub-and-spoke design pattern
- Multi-VPC architecture
- Centralized shared services
- Scalable và maintainable design

### 🔒 Multi-layer Security
- Security Groups và NACLs
- Network segmentation
- VPC Flow Logs monitoring
- Security best practices

### 📊 Comprehensive Monitoring
- CloudWatch metrics và alarms
- Custom dashboards
- Automated testing procedures
- Performance optimization

### 💰 Cost Optimization
- Resource right-sizing
- Reserved Instance planning
- Automated cost controls
- 30% cost reduction strategies

### 🔧 Operational Excellence
- Infrastructure as Code ready
- Automated procedures
- Troubleshooting guides
- Production-ready practices

## Lưu ý quan trọng

### ⚠️ Chi phí
- Workshop sẽ tạo ra chi phí AWS thực tế (~$47 cho 4 ngày)
- Theo dõi chi phí qua AWS Cost Explorer
- **Bắt buộc** thực hiện cleanup sau khi hoàn thành
- Set up billing alerts trước khi bắt đầu

### 🔒 Bảo mật
- Không sử dụng production account
- Sử dụng IAM user với permissions tối thiểu
- Không commit AWS credentials vào code
- Follow security best practices

### 🌍 Region
- Workshop được thiết kế cho ap-southeast-1 (Singapore)
- Có thể adapt cho regions khác nhưng cần điều chỉnh pricing
- Ensure service availability trong region được chọn

## Troubleshooting

### Lỗi thường gặp

1. **Permission Denied**
   - Kiểm tra IAM permissions
   - Đảm bảo có đủ quyền tạo VPC, EC2, Transit Gateway
   - Review service limits

2. **Resource Limits**
   - Kiểm tra service quotas
   - Request limit increase nếu cần
   - Monitor resource usage

3. **Connectivity Issues**
   - Kiểm tra Security Groups và NACLs
   - Verify Route Tables configuration
   - Check Transit Gateway routing

4. **Cost Concerns**
   - Monitor qua Cost Explorer
   - Set up billing alerts
   - Cleanup ngay khi hoàn thành
   - Review cost optimization chapter

### Support Resources
- Workshop troubleshooting guides trong mỗi chương
- AWS documentation links
- Community support forums

## Advanced Features

### Infrastructure as Code
- Terraform templates (coming soon)
- CloudFormation templates (coming soon)
- CDK examples (coming soon)

### CI/CD Integration
- GitHub Actions workflows
- AWS CodePipeline integration
- Automated testing procedures

### Multi-Region Support
- Cross-region peering
- Disaster recovery procedures
- Global network architecture

## Đóng góp

Nếu bạn tìm thấy lỗi hoặc muốn cải thiện workshop:

1. **Bug Reports**: Tạo issue với detailed description
2. **Feature Requests**: Submit enhancement proposals
3. **Pull Requests**: Contribute improvements
4. **Documentation**: Help improve documentation
5. **Feedback**: Share your workshop experience

### Contribution Guidelines
- Follow existing code style
- Include proper documentation
- Test changes thoroughly
- Update relevant sections

## License

Workshop này được phân phối dưới MIT License. Xem file LICENSE để biết thêm chi tiết.

## Acknowledgments

- AWS Documentation team
- AWS Solutions Architects
- Community contributors
- Workshop participants feedback

---

**🚀 Chúc bạn học tập hiệu quả với Advanced VPC Network Architecture Workshop!**

*Estimated completion time: 6-8 hours*  
*Difficulty level: Intermediate to Advanced*  
*Last updated: July 2025*
