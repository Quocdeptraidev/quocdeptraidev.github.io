---
title: "Phân tích Nhật ký luồng VPC"
date: "`r Sys.Date()`"
menu : "main"
weight: 3
chapter : false
pre : " <b> 6.3.3 </b> "
---

### 3.3 Phân tích Nhật ký luồng VPC

#### Giải thích:
Nhật ký luồng VPC (VPC Flow Logs) ghi lại tất cả lưu lượng IP đi vào và đi ra từ các giao diện mạng trong VPC của bạn. Việc phân tích các nhật ký này là một công cụ bảo mật và khắc phục sự cố mạnh mẽ. Nó giúp bạn:
*   **Phát hiện các hoạt động đáng ngờ:** Tìm kiếm các kết nối bị từ chối (`REJECT`), các địa chỉ IP lạ cố gắng truy cập tài nguyên của bạn, hoặc các mẫu lưu lượng bất thường.
*   **Xác minh quy tắc bảo mật:** Đảm bảo rằng Security Group và Network ACL đang chặn hoặc cho phép lưu lượng đúng như mong đợi.
*   **Khắc phục sự cố kết nối:** Xác định nguyên nhân gốc rễ của các vấn đề kết nối bằng cách xem xét chi tiết các gói tin bị rớt hoặc các luồng không mong muốn.
*   **Giám sát hiệu suất mạng:** Phân tích lượng dữ liệu truyền tải giữa các thành phần để phát hiện tắc nghẽn hoặc các mẫu lưu lượng bất thường.

Việc phân tích nhật ký luồng VPC từ các nhóm nhật ký riêng biệt cho Development, Hub và Production là cực kỳ quan trọng vì nó cho phép bạn:
*   **Giám sát chi tiết theo môi trường:** Dễ dàng tập trung vào lưu lượng và các sự kiện bảo mật cụ thể của từng môi trường mà không bị nhiễu bởi dữ liệu từ các môi trường khác.
*   **Khắc phục sự cố hiệu quả hơn:** Khi có vấn đề về kết nối hoặc bảo mật, bạn có thể nhanh chóng khoanh vùng vấn đề vào môi trường cụ thể và phân tích nhật ký liên quan.
*   **Đảm bảo tuân thủ và kiểm toán:** Cung cấp khả năng kiểm toán chi tiết về lưu lượng mạng trong từng môi trường, giúp đáp ứng các yêu cầu tuân thủ.
*   **Phát hiện bất thường:** Dễ dàng nhận biết các mẫu lưu lượng bất thường hoặc các nỗ lực truy cập trái phép trong từng khu vực riêng biệt của kiến trúc mạng.

#### Phân tích các Sự kiện Bảo mật (Thủ công)

Để phân tích nhật ký luồng VPC, bạn sẽ sử dụng AWS CLI để truy vấn CloudWatch Logs Insights.

**Lưu ý quan trọng:**
*   Bạn cần có quyền AWS CLI được cấu hình trên máy tính hoặc Bastion Host của bạn để truy cập CloudWatch Logs.
*   Bạn có thể điều chỉnh `1 hour ago` để thay đổi khoảng thời gian truy vấn.
*   Bạn có các nhóm nhật ký luồng VPC sau: `/aws/vpc/development/flowlogs`, `/aws/vpc/hub/flowlogs`, `/aws/vpc/production/flowlogs`. Bạn sẽ cần chạy các truy vấn dưới đây cho từng nhóm nhật ký để có cái nhìn toàn diện.

**1. Truy vấn các kết nối bị từ chối (các sự kiện bảo mật tiềm năng):**

Lệnh này sẽ tìm kiếm các kết nối bị từ chối trong nhật ký luồng VPC của bạn trong 1 giờ qua, nhóm theo địa chỉ IP nguồn, IP đích và cổng đích, sau đó sắp xếp theo số lượng bị từ chối.

*   **Đối với Development VPC, Hub VPC và Production VPC:**
    ```bash
    aws logs start-query \
        --log-group-name "/aws/vpc/development/flowlogs" "/aws/vpc/hub/flowlogs" "/aws/vpc/production/flowlogs" \
        --start-time $(date -d '1 hour ago' +%s) \
        --end-time $(date +%s) \
        --query-string 'fields @timestamp, srcaddr, dstaddr, srcport, dstport, protocol, action\
        | filter action = "REJECT"\
        | stats count() as rejected_count by srcaddr, dstaddr, dstport\
        | sort rejected_count desc\
        | limit 20'
    ```
![](/images/6.testing-monitoring/hinh-34.png)
*   **Kết quả mong đợi:** Mỗi lệnh sẽ trả về một bảng chứa `queryId`. Sau đó, bạn cần sử dụng `aws logs get-query-results --query-id <queryId>` để xem kết quả thực tế. Kết quả sẽ là một bảng liệt kê các địa chỉ IP nguồn, IP đích và cổng đích đã bị từ chối, cùng với số lượng lần bị từ chối. Nếu không có kết nối nào bị từ chối trong khoảng thời gian đó, bảng sẽ trống.
