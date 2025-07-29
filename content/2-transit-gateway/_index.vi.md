---
title: "Hướng Dẫn Cài Đặt AWS Transit Gateway"
date: "2025-07-12"
weight: 2
chapter: false
pre: " <b> 2. </b> "
---

Trong chương này, chúng ta sẽ tạo và cấu hình AWS Transit Gateway – thành phần trung tâm của kiến trúc hub-and-spoke.

## Tổng Quan về Transit Gateway

AWS Transit Gateway là một dịch vụ cho phép bạn kết nối các VPC và mạng tại chỗ (on-premises) thông qua một hub trung tâm. Điều này giúp đơn giản hóa mạng của bạn và loại bỏ các mối quan hệ peering phức tạp.

### Lợi Ích Chính:
- **Kết Nối Đơn Giản**: Kết nối nhiều VPC thông qua một điểm trung tâm.
- **Khả Năng Mở Rộng**: Hỗ trợ hàng nghìn kết nối VPC (attachments).
- **Định Tuyến Tập Trung**: Quản lý định tuyến từ một nơi duy nhất.
- **Peering Xuyên Vùng**: Kết nối các Transit Gateway ở các khu vực AWS khác nhau.

### Các phần trong chương này:
- [Bước 1: Tạo Transit Gateway](./2.1-create-transit-gateway/)
- [Bước 2: Tạo Bảng Định Tuyến](./2.2-create-route-tables/)
- [Bước 3: Cấu Hình Bảng Định Tuyến Mặc Định](./2.3-configure-default-route-table/)
- [Bước 4: Xác Minh Cấu Hình](./2.4-verify-configuration/)
- [Bước 5: Tối Ưu Hóa Chi Phí và Xử Lý Sự Cố](./2.5-cost-optimization-and-troubleshooting/)
- [Bước 6: Chủ Đề Nâng Cao và Chia Sẻ Tài Nguyên](./2.6-advanced-topic-resource-sharing/)
- [Bước 7: Các Bước Tiếp Theo](./2.7-next-steps/)