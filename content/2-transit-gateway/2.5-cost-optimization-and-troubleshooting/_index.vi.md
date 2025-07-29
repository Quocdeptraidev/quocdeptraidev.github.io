---
title: "Tối Ưu Hóa Chi Phí và Xử Lý Sự Cố"
date: "2025-07-12"
weight: 5
menu : "main"
chapter : false
pre : " <b> 2.5 </b> "
---

### Mô Hình Giá
- **Phí theo giờ**: Khoảng $0.05/giờ cho mỗi Transit Gateway attachment.
- **Phí xử lý dữ liệu**: $0.02/GB dữ liệu được xử lý.

### Xử Lý Sự Cố Thường Gặp
- **Transit Gateway bị kẹt ở trạng thái "Pending"**: Chờ thêm hoặc kiểm tra giới hạn dịch vụ (service quotas).
- **Không thể tạo attachment**: Đảm bảo Transit Gateway ở trạng thái "Available" và bạn có đủ quyền IAM.
- **Sự cố định tuyến**: Kiểm tra lại các associations và propagations trong bảng định tuyến.
