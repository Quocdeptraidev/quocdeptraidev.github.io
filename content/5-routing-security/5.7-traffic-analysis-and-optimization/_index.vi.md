---
title: "Phân tích và Tối ưu hóa Lưu lượng"
menu : "main"
weight: 7
chapter : false
pre : " <b> 5.7 </b> "
---

Sử dụng các công cụ của AWS để phân tích nhật ký luồng, giúp tối ưu hóa hiệu suất và tăng cường bảo mật.

### 7.1 Phân tích Nhật ký luồng

Sử dụng **CloudWatch Logs Insights** để chạy các truy vấn tương tác trên dữ liệu nhật ký luồng của bạn.

#### Truy vấn cho các nguồn/đích có lưu lượng cao nhất
Giúp xác định các ứng dụng hoặc máy chủ sử dụng băng thông bất thường.
```sql
fields @timestamp, srcaddr, dstaddr, bytes
| filter action = "ACCEPT"
| stats sum(bytes) as total_bytes by srcaddr, dstaddr
| sort total_bytes desc
| limit 20
```
![](/images/5.routing-security/hinh-61.png)
![](/images/5.routing-security/hinh-62.png)
![](/images/5.routing-security/hinh-63.png)

#### Truy vấn cho Lưu lượng bị từ chối
Quan trọng để phát hiện các nỗ lực truy cập trái phép hoặc các cấu hình sai.
```sql
fields @timestamp, srcaddr, dstaddr, srcport, dstport, protocol
| filter action = "REJECT"
| stats count() as rejected_count by srcaddr, dstaddr, dstport
| sort rejected_count desc
| limit 10
```
![](/images/5.routing-security/hinh-57.png)
![](/images/5.routing-security/hinh-58.png)
![](/images/5.routing-security/hinh-59.png)

### 7.2 Tối ưu hóa Hiệu suất

#### Tối ưu hóa Bảng Định tuyến
Thường xuyên kiểm tra và dọn dẹp các tuyến đường không cần thiết trong bảng định tuyến Transit Gateway.
```bash
aws ec2 search-transit-gateway-routes \
    --transit-gateway-route-table-id tgw-rtb-xxxxxxxxx \
    --filters "Name=state,Values=active"
```
![](/images/5.routing-security/hinh-64.png)

#### Giám sát Băng thông
Sử dụng CloudWatch để theo dõi việc sử dụng băng thông của Transit Gateway và xác định các điểm nghẽn tiềm ẩn.
```bash
aws cloudwatch get-metric-statistics \
    --namespace AWS/TransitGateway \
    --metric-name BytesIn \
    --dimensions Name=TransitGateway,Value=tgw-xxxxxxxxx \
    --start-time 2024-07-10T00:00:00Z \
    --end-time 2024-07-11T00:00:00Z \
    --period 3600 \
    --statistics Sum
```
![](/images/5.routing-security/hinh-65.png)
![](/images/5.routing-security/hinh-66.png)