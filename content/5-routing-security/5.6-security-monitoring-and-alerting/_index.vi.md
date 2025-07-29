---
title: "Giám sát và Cảnh báo Bảo mật"
menu : "main"
weight: 6
chapter : false
pre : " <b> 5.6 </b> "
---

Thiết lập giám sát và cảnh báo chủ động là rất quan trọng để phát hiện và phản ứng nhanh chóng với các sự kiện bảo mật tiềm ẩn. Phần này sẽ hướng dẫn bạn cách cấu hình các cảnh báo CloudWatch và sử dụng các dịch vụ giám sát mối đe dọa như Amazon GuardDuty.

### 6.1 Cảnh báo CloudWatch

Chúng ta tạo các cảnh báo dựa trên các chỉ số (metrics) của Transit Gateway để thông báo về các hoạt động bất thường, chẳng hạn như lưu lượng liên-VPC cao hoặc số lượng kết nối bị từ chối tăng đột biến.

#### Cảnh báo các mẫu lưu lượng bất thường
Cảnh báo này sẽ được kích hoạt khi lưu lượng BytesIn (lưu lượng vào) trên Transit Gateway vượt quá một ngưỡng nhất định, cho thấy một mẫu lưu lượng bất thường giữa các VPC.

```bash
aws cloudwatch put-metric-alarm \
    --alarm-name "High-Cross-VPC-Traffic" \
    --alarm-description "Cảnh báo về lưu lượng liên-VPC cao" \
    --metric-name BytesIn \
    --namespace AWS/TransitGateway \
    --statistic Sum \
    --period 300 \
    --threshold 1000000000 \
    --comparison-operator GreaterThanThreshold \
    --evaluation-periods 2
```
![](/images/5.routing-security/hinh-37.png)
![](/images/5.routing-security/hinh-38.png)

#### Cảnh báo các nỗ lực kết nối thất bại
Cảnh báo này sẽ được kích hoạt khi số lượng gói tin bị từ chối (PacketDropCount) trên Transit Gateway vượt quá một ngưỡng nhất định, cho thấy các nỗ lực kết nối không thành công hoặc các vấn đề về cấu hình bảo mật.

```bash
aws cloudwatch put-metric-alarm \
    --alarm-name "High-Rejected-Connections" \
    --alarm-description "Cảnh báo về số lượng kết nối bị từ chối cao" \
    --metric-name PacketDropCount \
    --namespace AWS/TransitGateway \
    --statistic Sum \
    --period 300 \
    --threshold 1000 \
    --comparison-operator GreaterThanThreshold \
    --evaluation-periods 1
```
![](/images/5.routing-security/hinh-39.png)
![](/images/5.routing-security/hinh-40.png)

### 6.2 Các chỉ số tùy chỉnh

Sử dụng hàm Lambda để thu thập các chỉ số tùy chỉnh, chẳng hạn như số lượng quy tắc trong các nhóm bảo mật, và gửi chúng đến CloudWatch để theo dõi. Điều này giúp bạn giám sát sự thay đổi trong cấu hình bảo mật theo thời gian.

#### Sử dụng Quy tắc Nhóm Bảo mật
```python
import boto3
import json

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')
    cloudwatch = boto3.client('cloudwatch')
    
    # Lấy tất cả các nhóm bảo mật
    response = ec2.describe_security_groups()
    
    for sg in response['SecurityGroups']:
        # Đếm các quy tắc inbound
        inbound_rules = len(sg['IpPermissions'])
        
        # Đếm các quy tắc outbound
        outbound_rules = len(sg['IpPermissionsEgress'])
        
        # Gửi các chỉ số đến CloudWatch
        cloudwatch.put_metric_data(
            Namespace='Custom/Security',
            MetricData=[
                {
                    'MetricName': 'InboundRules',
                    'Dimensions': [
                        {
                            'Name': 'SecurityGroupId',
                            'Value': sg['GroupId']
                        }
                    ],
                    'Value': inbound_rules
                },
                {
                    'MetricName': 'OutboundRules',
                    'Dimensions': [
                        {
                            'Name': 'SecurityGroupId',
                            'Value': sg['GroupId']
                        }
                    ],
                    'Value': outbound_rules
                }
            ]
        )
```

#### Hướng dẫn triển khai hàm Lambda này

Để triển khai và sử dụng hàm Lambda này, hãy làm theo các bước sau:

**Trước khi bắt đầu, bạn cần:**

*   Một tài khoản AWS đang hoạt động.
*   Truy cập vào Bảng điều khiển quản lý AWS.
*   Quyền tạo hàm Lambda, vai trò IAM và nhóm nhật ký CloudWatch.

**Các bước triển khai hàm Lambda:**

**Bước 1: Tạo vai trò IAM cho Lambda**

Hàm Lambda cần có quyền để đọc thông tin Nhóm Bảo mật và ghi các chỉ số vào CloudWatch.

1.  Mở Bảng điều khiển quản lý AWS và tìm kiếm "IAM".
2.  Trong bảng điều khiển IAM, chọn **Roles** (Vai trò) từ menu bên trái.
3.  Nhấp vào **Create role** (Tạo vai trò).
4.  Chọn **AWS service** (Dịch vụ AWS) và chọn **Lambda** làm trường hợp sử dụng. Nhấp **Next**.
5.  Trong phần **Add permissions** (Thêm quyền), tìm kiếm và chọn các chính sách sau:
    *   `AWSLambdaBasicExecutionRole` (để ghi nhật ký vào CloudWatch Logs)
    *   `AmazonEC2ReadOnlyAccess` (để đọc thông tin Nhóm Bảo mật)
    *   `CloudWatchFullAccess` (để ghi các chỉ số tùy chỉnh vào CloudWatch)
    *   *Lưu ý:* `CloudWatchFullAccess` là một quyền rộng. Trong môi trường sản xuất, bạn nên tạo một chính sách tùy chỉnh chỉ cho phép `cloudwatch:PutMetricData` cho không gian tên `Custom/Security`.
6.  Nhấp **Next**.
7.  (Tùy chọn) Thêm thẻ nếu bạn muốn. Nhấp **Next**.
8.  Đặt tên cho vai trò, ví dụ: `LambdaSecurityMetricsRole`.
9.  Nhấp **Create role** (Tạo vai trò).

**Bước 2: Tạo hàm Lambda**

1.  Mở Bảng điều khiển quản lý AWS và tìm kiếm "Lambda".
2.  Trong bảng điều khiển Lambda, nhấp vào **Create function** (Tạo hàm).
3.  Chọn **Author from scratch** (Tạo từ đầu).
4.  **Thông tin cơ bản:**
    *   **Tên hàm:** Đặt tên, ví dụ: `SecurityGroupMetricsCollector`.
    *   **Môi trường chạy:** Chọn `Python 3.9` (hoặc phiên bản Python mới nhất được hỗ trợ).
    *   **Kiến trúc:** Chọn `x86_64`.
    
![](/images/5.routing-security/hinh-41.png)
5.  **Thay đổi vai trò thực thi mặc định:**
    *   Mở rộng phần **Thay đổi vai trò thực thi mặc định**.
    *   Chọn **Use an existing role** (Sử dụng vai trò hiện có).
    *   Trong danh sách thả xuống **Existing role**, chọn vai trò bạn đã tạo ở Bước 1 (ví dụ: `LambdaSecurityMetricsRole`).
    ![](/images/5.routing-security/hinh-42.png)
6.  Nhấp vào **Create function** (Tạo hàm).

**Bước 3: Dán mã vào hàm Lambda**

1.  Sau khi hàm được tạo, bạn sẽ được đưa đến trang cấu hình của hàm. Cuộn xuống phần **Mã nguồn**.
2.  Bạn sẽ thấy một trình chỉnh sửa mã. Xóa bất kỳ mã mẫu nào hiện có.
3.  Dán toàn bộ đoạn mã Python của hàm vào trình chỉnh sửa.
![](/images/5.routing-security/hinh-43.png)
4.  Nhấp vào **Deploy** (Triển khai) để lưu mã của bạn.
![](/images/5.routing-security/hinh-44.png)
**Bước 4: Cấu hình trình kích hoạt theo lịch trình**

Bạn muốn hàm này chạy định kỳ để thu thập các chỉ số.

1.  Trên trang cấu hình hàm Lambda của bạn, trong phần **Tổng quan hàm**, nhấp vào **Add trigger** (Thêm trình kích hoạt).

![](/images/5.routing-security/hinh-45.png)
2.  Trong danh sách thả xuống **Select a source** (Chọn nguồn), chọn **EventBridge (CloudWatch Events)**.

![](/images/5.routing-security/hinh-46.png)
3.  **EventBridge (CloudWatch Events):**
    *   **Quy tắc:** Chọn **Create a new rule** (Tạo quy tắc mới).
    *   **Tên quy tắc:** Đặt tên, ví dụ: `EveryHourSecurityMetrics`.

![](/images/5.routing-security/hinh-47.png)
    *   **Loại quy tắc:** Chọn **Schedule expression** (Biểu thức lịch trình).
    *   **Biểu thức lịch trình:** Nhập `rate(1 hour)` để chạy mỗi giờ, hoặc `cron(0 0 * * ? *)` để chạy hàng ngày vào lúc nửa đêm UTC.

![](/images/5.routing-security/hinh-48.png)
    *   **Bật trình kích hoạt:** Make sure this checkbox is selected.
4.  Nhấp vào **Add** (Thêm).

**Bước 5: Kiểm tra hàm Lambda**

1.  Trên trang cấu hình hàm Lambda, nhấp vào nút **Test** (Kiểm tra) ở phía trên cùng.
![](/images/5.routing-security/hinh-49.png)
2.  Trong cửa sổ **Configure test event** (Cấu hình sự kiện kiểm tra):
    *   **Tên sự kiện:** Đặt tên, ví dụ: `TestEvent`.

![](/images/5.routing-security/hinh-50.png)
    *   **JSON sự kiện:** Để trống `{}` vì hàm này không yêu cầu đầu vào cụ thể.

![](/images/5.routing-security/hinh-51.png)
3.  Nhấp vào **Save** (Lưu).

![](/images/5.routing-security/hinh-52.png)
4.  Nhấp lại vào nút **Test** (Kiểm tra).

![](/images/5.routing-security/hinh-53.png)
Sau khi chạy thử nghiệm, bạn sẽ thấy kết quả thực thi. Nếu thành công, bạn có thể truy cập CloudWatch để xem các chỉ số tùy chỉnh của mình:

1.  Mở Bảng điều khiển quản lý AWS và tìm kiếm "CloudWatch".
2.  Trong bảng điều khiển CloudWatch, chọn **Metrics** (Chỉ số) từ menu bên trái.
3.  Tìm kiếm không gian tên `Custom/Security`. Bạn sẽ thấy các chỉ số `InboundRules` và `OutboundRules` được tạo bởi hàm Lambda của bạn.

![](/images/5.routing-security/hinh-54.png)

### 6.3 Khắc phục sự cố triển khai Lambda (Lỗi Timeout)

Nếu bạn gặp lỗi `{"errorType": "Sandbox.Timedout", "errorMessage": "RequestId: ... Error: Task timed out after 3.00 seconds"}` khi kiểm tra hàm Lambda, điều đó có nghĩa là hàm của bạn đã chạy quá thời gian cho phép (mặc định 3 giây) trước khi hoàn thành.

Để khắc phục điều này:

1.  **Mở bảng điều khiển Lambda:** Truy cập hàm Lambda của bạn (ví dụ: `SecurityGroupMetricsCollector`).
2.  **Chuyển đến tab "Configuration" (Cấu hình):** Trên trang tổng quan của hàm, nhấp vào tab **Configuration**.
3.  **Chọn "General configuration" (Cấu hình chung):** Trong menu bên trái của tab Configuration, chọn **General configuration**.
4.  **Chỉnh sửa thời gian chờ:** Nhấp vào nút **Edit** (Chỉnh sửa) ở góc trên bên phải.
![](/images/5.routing-security/hinh-55.png)
5.  **Tăng "Timeout":** Thay đổi giá trị "Timeout" từ 3 giây lên một giá trị cao hơn, ví dụ: **30 giây** hoặc **1 phút**.
![](/images/5.routing-security/hinh-56.png)
6.  Nhấp vào **Save** (Lưu).

### 6.4 Giám sát Mối đe dọa với Amazon GuardDuty

Ngoài việc thiết lập các cảnh báo tùy chỉnh, bạn nên bật **Amazon GuardDuty** để tăng cường bảo mật. Đây là dịch vụ phát hiện mối đe dọa thông minh, liên tục giám sát các hành vi độc hại hoặc trái phép trong môi trường AWS của bạn.

**Cách GuardDuty hoạt động:**
- **Phân tích các nguồn dữ liệu:** GuardDuty tự động phân tích các nhật ký AWS CloudTrail, VPC Flow Logs, và DNS logs.
- **Sử dụng Machine Learning:** Dịch vụ sử dụng máy học, phát hiện sự bất thường và thông tin về mối đe dọa tích hợp để xác định và ưu tiên các mối đe dọa tiềm ẩn.
- **Tạo ra các phát hiện (Findings):** Khi phát hiện một mối đe dọa, GuardDuty sẽ tạo ra một "finding" chi tiết, giúp bạn nhanh chóng hiểu và phản ứng với các vấn đề bảo mật.

Bật GuardDuty là một thực hành tốt nhất (best practice) để có một lớp giám sát bảo mật chủ động mà không cần phải quản lý các quy tắc phức tạp.


Thiết lập giám sát và cảnh báo chủ động cho phép chúng ta phát hiện và phản ứng nhanh chóng với các sự kiện bảo mật tiềm ẩn.

