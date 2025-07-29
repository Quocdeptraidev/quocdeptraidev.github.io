---
title: "Phân đoạn Lưu lượng"
menu : "main"
weight: 2
chapter : false
pre : " <b> 5.2 </b> "
---

Phân đoạn lưu lượng là một biện pháp bảo mật quan trọng để cô lập các môi trường và kiểm soát giao tiếp giữa chúng.

{{% notice info %}}
**Lưu ý về một lớp bảo mật nâng cao: AWS Network Firewall**

Ngoài việc sử dụng Security Groups và Network ACLs, trong các môi trường sản xuất yêu cầu bảo mật cao, **AWS Network Firewall** thường được triển khai trong Hub VPC. Đây là một dịch vụ tường lửa được quản lý, cho phép bạn triển khai các quy tắc lọc chi tiết cho toàn bộ lưu lượng đi qua Transit Gateway.

**Lợi ích chính:**
- **Kiểm tra và lọc lưu lượng tập trung:** Thay vì quản lý các quy tắc phức tạp trên nhiều NACL, bạn có thể định nghĩa các chính sách bảo mật tại một nơi duy nhất.
- **Bảo vệ nâng cao:** Cung cấp khả năng ngăn chặn xâm nhập (IPS), lọc web và kiểm tra lưu lượng dựa trên các quy tắc phức tạp hơn.

Trong kiến trúc của chúng ta, AWS Network Firewall sẽ được đặt trong Hub VPC, và tất cả lưu lượng từ các Spoke VPC sẽ được định tuyến qua nó trước khi đi ra internet hoặc đi đến các VPC khác.
{{% /notice %}}

### 2.1 Cách ly Sản xuất-Phát triển

Để ngăn chặn giao tiếp trực tiếp giữa môi trường Sản xuất (Production) và Phát triển (Development), chúng ta tạo các bảng định tuyến riêng biệt.

1.  Tạo **Prod-Only-Route-Table**:
![](/images/5.routing-security/hinh-4.png)
    ```
    Routes:
    - 10.0.0.0/16 → Hub VPC (chỉ dịch vụ chia sẻ)
    - 0.0.0.0/0 → Hub VPC (truy cập internet)
    # KHÔNG có tuyến đường đến 10.2.0.0/16 (Phát triển)
    ```
![](/images/5.routing-security/hinh-5.png)

2.  Tạo **Dev-Only-Route-Table**:
![](/images/5.routing-security/hinh-6.png)
    ```
    Routes:
    - 10.0.0.0/16 → Hub VPC (chỉ dịch vụ chia sẻ)
    - 0.0.0.0/0 → Hub VPC (truy cập internet)
    # KHÔNG có tuyến đường đến 10.1.0.0/16 (Sản xuất)
    ```
![](/images/5.routing-security/hinh-7.png)

3.  Liên kết lại các tệp đính kèm VPC:
    -   Production VPC → Prod-Only-Route-Table
    -   Development VPC → Dev-Only-Route-Table

### 2.2 Định tuyến có điều kiện

Triển khai định tuyến có điều kiện dựa trên nguồn để kiểm soát truy cập đến các dịch vụ cụ thể.

```bash
# Định tuyến từ Sản xuất đến chỉ các dịch vụ cụ thể
aws ec2 create-route \
    --route-table-id tgw-rtb-prod \
    --destination-cidr-block 10.0.10.0/24 \
    --transit-gateway-attachment-id tgw-attach-hub
```
![](/images/5.routing-security/hinh-8.png)
