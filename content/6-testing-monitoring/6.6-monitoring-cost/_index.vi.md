---
title: "Chi phí Giám sát"
date: "`r Sys.Date()`"
menu : "main"
weight: 6
chapter : false
pre : " <b> 6.6 </b> "
---

## Chi phí Giám sát

{{% notice info %}}
Việc hiểu rõ và tối ưu hóa chi phí giám sát là rất quan trọng để quản lý ngân sách hiệu quả trong môi trường đám mây. Các dịch vụ giám sát như CloudWatch có thể phát sinh chi phí dựa trên lượng dữ liệu được thu thập, số lượng cảnh báo và tần suất truy vấn. Bằng cách áp dụng các chiến lược tối ưu hóa chi phí, bạn có thể giảm thiểu chi phí mà vẫn duy trì khả năng giám sát cần thiết.
{{% /notice %}}

### Chi phí Giám sát
- **Chỉ số CloudWatch**: ~$0.30/chỉ số/tháng
- **Nhật ký CloudWatch**: ~$0.50/GB được nhập
- **Cảnh báo CloudWatch**: ~$0.10/cảnh báo/tháng
- **Hàm Lambda**: ~$0.20/1M yêu cầu
- **Tổng ước tính**: ~$20-30/tháng

### Tối ưu hóa Chi phí
1. **Lọc nhật ký** để giảm chi phí nhập
2. **Sử dụng bộ lọc chỉ số** thay vì chỉ số tùy chỉnh nếu có thể
3. **Đặt thời gian lưu giữ** phù hợp
4. **Lưu trữ dữ liệu cũ** vào S3
