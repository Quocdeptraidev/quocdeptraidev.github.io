---
title: "Cấu Hình Bảng Định Tuyến Mặc Định"
date: "2025-07-12"
weight: 3
menu : "main"
chapter : false
pre : " <b> 2.3 </b> "
---

### 3.1. Vô Hiệu Hóa Liên Kết và Quảng Bá Mặc Định

Chúng ta sẽ vô hiệu hóa các hành vi mặc định trên bảng định tuyến gốc của Transit Gateway để đảm bảo kiểm soát hoàn toàn.

1.  Điều hướng đến **Transit Gateway Route Tables**.
2.  Chọn bảng định tuyến **mặc định** của `Hub-TGW` (bảng không có tên `Hub-Route-Table` hay `Spoke-Route-Table`).
3.  Chọn tab **Associations**, chọn tất cả các liên kết và nhấp **Delete association**.
4.  Chọn tab **Propagations**, chọn tất cả các quảng bá và nhấp **Delete propagation**.

{{% notice note %}}
Nếu các tab **Associations** và **Propagations** đã trống sẵn, bạn không cần thực hiện hành động xóa và có thể bỏ qua bước này.
{{% /notice %}}

{{% notice warning %}}
Việc vô hiệu hóa bảng định tuyến mặc định đảm bảo rằng bạn có toàn quyền kiểm soát luồng traffic và tránh các kết nối không mong muốn.
{{% /notice %}}
