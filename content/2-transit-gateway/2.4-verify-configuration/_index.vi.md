---
title: "Xác Minh Cấu Hình"
date: "2025-07-12"
weight: 4
menu : "main"
chapter : false
pre : " <b> 2.4 </b> "
---

### 4.1. Kiểm Tra Trạng Thái Transit Gateway

1.  Trong VPC Console, chọn **Transit Gateways**.
2.  Xác minh rằng trạng thái của `Hub-TGW` là **Available**.

![](/images/2.transit-gateway/hinh13.png)
3.  Ghi lại **Transit Gateway ID** để sử dụng cho các bước tiếp theo.

### 4.2. Kiểm Tra Các Bảng Định Tuyến

1.  Chọn **Transit Gateway Route Tables**.
2.  Xác minh rằng các bảng `Hub-Route-Table` và `Spoke-Route-Table` đã được tạo thành công và bảng định tuyến mặc định không có Associations hay Propagations nào.

![](/images/2.transit-gateway/hinh14.png)
