---
title: "Bảng điều khiển CloudWatch"
date: "`r Sys.Date()`"
menu : "main"
weight: 1
chapter : false
pre : " <b> 6.5.1 </b> "
---

### 5.1 Bảng điều khiển CloudWatch

#### Giải thích:
Bảng điều khiển CloudWatch (CloudWatch Dashboards) cung cấp một cái nhìn tổng quan, tập trung về các tài nguyên và ứng dụng của bạn. Bằng cách tạo các bảng điều khiển tùy chỉnh, bạn có thể trực quan hóa các chỉ số quan trọng (metrics) từ nhiều dịch vụ AWS khác nhau (như EC2, Transit Gateway, VPC Flow Logs) trên một màn hình duy nhất. Điều này giúp bạn nhanh chóng theo dõi hiệu suất, phát hiện các vấn đề, và đưa ra quyết định dựa trên dữ liệu theo thời gian thực. Việc có một bảng điều khiển giám sát toàn diện là rất quan trọng để duy trì sự ổn định và hiệu suất của kiến trúc mạng hub-and-spoke của bạn.

#### Tạo Bảng điều khiển Tùy chỉnh (Thủ công)

Bạn có thể tạo bảng điều khiển CloudWatch thông qua giao diện điều khiển AWS hoặc bằng AWS CLI. Dưới đây là ví dụ về cấu hình JSON cho một bảng điều khiển tùy chỉnh, tập trung vào lưu lượng Transit Gateway và lưu lượng mạng Instance.

**Lưu ý quan trọng:**
*   Thay thế `tgw-xxxxxxxxx` bằng ID Transit Gateway thực tế của bạn.
*   Thay thế `i-prod-xxxxxxxxx` và `i-dev-xxxxxxxxx` bằng ID instance Production và Development thực tế của bạn.
*   `ap-southeast-1` là khu vực ví dụ; hãy thay thế bằng khu vực AWS của bạn.

**1. Tạo file JSON cho bảng điều khiển:**

Tạo một file mới có tên `dashboard.json` trên máy tính của bạn (hoặc Bastion Host) và dán nội dung sau vào:
![](/images/6.testing-monitoring/hinh-44.png)
```json
{
    "widgets": [
        {
            "type": "metric",
            "properties": {
                "metrics": [
                    [ "AWS/TransitGateway", "BytesIn", "TransitGateway", "tgw-xxxxxxxxx" ],
                    [ ".", "BytesOut", ".", "." ],
                    [ ".", "PacketsIn", ".", "." ],
                    [ ".", "PacketsOut", ".", "." ]
                ],
                "period": 300,
                "stat": "Sum",
                "region": "ap-southeast-1",
                "title": "Lưu lượng Transit Gateway"
            }
        },
        {
            "type": "metric",
            "properties": {
                "metrics": [
                    [ "AWS/EC2", "NetworkIn", "InstanceId", "i-prod-xxxxxxxxx" ],
                    [ ".", "NetworkOut", ".", "." ],
                    [ ".", "NetworkIn", ".", "i-dev-xxxxxxxxx" ],
                    [ ".", "NetworkOut", ".", "." ]
                ],
                "period": 300,
                "stat": "Average",
                "region": "ap-southeast-1",
                "title": "Lưu lượng Mạng Instance"
            }
        }
    ]
}
```
![](/images/6.testing-monitoring/hinh-45.png)
**2. Triển khai Bảng điều khiển bằng AWS CLI:**

Sau khi tạo file `dashboard.json`, chạy lệnh sau để tạo bảng điều khiển trong CloudWatch:

```bash
aws cloudwatch put-dashboard \
    --dashboard-name "VPC-Architecture-Monitoring" \
    --dashboard-body file://dashboard.json
```
![](/images/6.testing-monitoring/hinh-46.png)
*   **Kết quả mong đợi:** Lệnh sẽ trả về một phản hồi JSON xác nhận bảng điều khiển đã được tạo hoặc cập nhật thành công. Bạn có thể kiểm tra bảng điều khiển này trong giao diện điều khiển CloudWatch của AWS.

