---
title: "Kiểm thử Kết nối"
date: "`r Sys.Date()`"
menu : "main"
weight: 1
chapter : false
pre : " <b> 6.1 </b> "
---

# Tổng quan Chiến lược Kiểm thử

Kiểm thử toàn diện bao gồm:

- **Kiểm thử Kết nối**: Xác minh các đường dẫn mạng
- **Kiểm thử Hiệu suất**: Đo độ trễ và thông lượng
- **Kiểm thử Bảo mật**: Xác thực các kiểm soát bảo mật
- **Kiểm thử Chuyển đổi dự phòng**: Kiểm thử tính sẵn sàng cao
- **Kiểm thử Tải**: Kiểm thử căng thẳng kiến trúc


## Bước 1: Kiểm thử Kết nối

{{% notice tip %}}
Kiểm thử kết nối là bước đầu tiên và quan trọng nhất để đảm bảo rằng tất cả các thành phần trong kiến trúc hub-and-spoke của bạn có thể giao tiếp với nhau một cách chính xác. Điều này bao gồm việc xác minh kết nối cơ bản, kết nối nâng cao đến các cổng cụ thể, và khả năng phân giải DNS.
{{% /notice %}}