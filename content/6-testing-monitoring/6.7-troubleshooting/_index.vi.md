---
title: "Khắc phục sự cố Thường gặp"
date: "`r Sys.Date()`"
menu : "main"
weight: 7
chapter : false
pre : " <b> 6.7 </b> "
---

## Khắc phục sự cố Thường gặp

{{% notice info %}}
Trong quá trình vận hành kiến trúc mạng hub-and-spoke, việc gặp phải các sự cố là điều không thể tránh khỏi. Phần này cung cấp hướng dẫn về cách khắc phục các vấn đề phổ biến liên quan đến độ trễ cao, vấn đề kết nối và giảm hiệu suất. Việc hiểu rõ các nguyên nhân gốc rễ và các bước khắc phục sẽ giúp bạn nhanh chóng giải quyết các sự cố và duy trì hoạt động ổn định của hệ thống.
{{% /notice %}}

### 1. Độ trễ cao
- Kiểm tra bảng định tuyến Transit Gateway
- Xác minh các instance nằm trong các AZ chính xác
- Xem xét các quy tắc nhóm bảo mật
- Kiểm tra tắc nghẽn mạng

### 2. Vấn đề Kết nối
- Xác minh cấu hình bảng định tuyến
- Kiểm tra các quy tắc nhóm bảo mật
- Xác thực cài đặt Network ACL
- Xác nhận các tệp đính kèm Transit Gateway

### 3. Giảm hiệu suất
- Giám sát các chỉ số CloudWatch
- Kiểm tra các hạn chế tài nguyên
- Xem xét việc sử dụng mạng
- Xác thực các loại instance
