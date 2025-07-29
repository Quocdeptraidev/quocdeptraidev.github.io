---
title: "Kiểm tra Cấu hình Bảo mật"
menu : "main"
weight: 10
chapter : false
pre : " <b> 5.10 </b> "
---
Sau khi triển khai các biện pháp bảo mật, việc kiểm tra là rất quan trọng để xác minh rằng các biện pháp kiểm soát của bạn hoạt động như mong đợi và không có lỗ hổng nào bị bỏ sót. Phần này sẽ hướng dẫn bạn cách thực hiện kiểm tra kết nối và xác thực bảo mật.

### 10.1 Kiểm tra Kết nối

Sử dụng các công cụ như `nc` (Netcat) từ Bastion Host để kiểm tra xem các kết nối được phép có thành công không và các kết nối bị cấm có thực sự bị chặn không. Điều này giúp xác nhận rằng các Security Group và Network ACL đang hoạt động đúng.

**Lưu ý về địa chỉ IP:**
*   `10.1.1.10` và `10.2.1.10` là các giá trị giữ chỗ. Bạn cần thay thế chúng bằng **IP riêng** của các instance của bạn trong VPC Sản xuất và VPC Phát triển.
*   Bạn có thể tìm các địa chỉ IP này trong Bảng điều khiển quản lý AWS, dưới dịch vụ **EC2**, chọn **Instances**, sau đó chọn instance mong muốn và xem trong phần **Details** (hoặc **Description**).

**Giải thích kết quả kiểm tra kết nối:**

*   **Cổng 22 (SSH):** Thường sẽ **thành công** khi kiểm tra từ Bastion Host đến các instance nội bộ. Điều này là mong đợi vì Bastion Host được thiết kế để là một điểm truy cập quản trị an toàn.
*   **Cổng 80 (HTTP) / 443 (HTTPS):**
    *   Nếu bạn kiểm tra đến một instance Tầng Web, nó có thể **thành công** nếu Nhóm Bảo mật của instance cho phép truy cập từ Bastion Host (ít phổ biến hơn) hoặc nếu bạn đang kiểm tra đến một Load Balancer.
    *   Tuy nhiên, nếu nó **timeout** khi kiểm tra trực tiếp đến instance Tầng Web từ Bastion Host, điều này thường là **đúng và mong đợi**. Nó cho thấy Nhóm Bảo mật của instance chỉ cho phép truy cập từ Load Balancer, đảm bảo lưu lượng đi qua luồng thiết kế.
*   **Cổng 3389 (RDP) / 1433 (SQL Server):** Các cổng này thường sẽ **timeout** khi kiểm tra từ Bastion Host đến các instance Sản xuất (trừ khi có cấu hình cụ thể cho phép truy cập quản trị rất hạn chế). Việc chúng bị timeout là **dấu hiệu của một cấu hình bảo mật tốt**, cho thấy các cổng nhạy cảm này được bảo vệ khỏi truy cập trái phép, thực thi nguyên tắc đặc quyền tối thiểu.

#### Kiểm tra các Kết nối được phép
```bash
# Từ bastion host, kiểm tra kết nối đến từng môi trường
ssh -i key.pem ec2-user@bastion-host
```
![](/images/5.routing-security/hinh-73.png)
# Kiểm tra kết nối Sản xuất

Sau khi triển khai, việc kiểm tra là rất quan trọng để xác minh rằng các biện pháp kiểm soát bảo mật của bạn hoạt động như mong đợi.

### 10.1 Kiểm tra Kết nối

Sử dụng các công cụ như `nc` (Netcat) từ Bastion Host để kiểm tra xem các kết nối được phép có thành công không và các kết nối bị cấm có thực sự bị chặn không.

#### Kiểm tra các Kết nối được phép
```bash
# Từ bastion host, kiểm tra kết nối SSH đến instance sản xuất
nc -zv 10.1.1.10 22  # Nên thành công
```
![](/images/5.routing-security/hinh-73.png)

#### Kiểm tra các Kết nối bị chặn
```bash
# Kiểm tra kết nối RDP đến instance sản xuất
nc -zv 10.1.1.10 3389  # Nên bị chặn (timeout)

# Kiểm tra kết nối từ sản xuất đến phát triển
nc -zv 10.2.1.10 22  # Nên thất bại nếu bị cách ly
```
![](/images/5.routing-security/hinh-74.png)
![](/images/5.routing-security/hinh-75.png)

### 10.2 Xác thực Bảo mật

Sử dụng danh sách kiểm tra để thực hiện kiểm thử xâm nhập cơ bản và xác thực các chính sách bảo mật.

#### Danh sách kiểm tra
- [ ] Xác minh các quy tắc nhóm bảo mật có tính hạn chế.
- [ ] Kiểm tra xem NACL có chặn lưu lượng trái phép không.
- [ ] Xác nhận cách ly liên môi trường.
- [ ] Xác thực rằng chỉ các cổng được ủy quyền mới mở.
- [ ] Kiểm tra xem truy cập internet có được kiểm soát đúng cách không.