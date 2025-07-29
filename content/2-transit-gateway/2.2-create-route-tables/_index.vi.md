---
title: "Tạo các Bảng Định Tuyến (Route Tables) Tùy Chỉnh"
date: "2025-07-12"
weight: 2
menu : "main"
chapter : false
pre : " <b> 2.2 </b> "
---

Để kiểm soát luồng traffic tốt hơn, chúng ta sẽ tạo các bảng định tuyến tùy chỉnh thay vì sử dụng bảng mặc định.

### 2.1. Tạo Bảng Định Tuyến cho Hub

1.  Trong VPC Console, ở menu trái, chọn **Transit Gateway Route Tables**.

![](/images/2.transit-gateway/hinh8.png)
2.  Nhấp **Create Transit Gateway Route Table**.

![](/images/2.transit-gateway/hinh9.png)
3.  Cấu hình:
    | Tham Số | Giá Trị |
    | :--- | :--- |
    | **Name tag** | `Hub-Route-Table` |
    | **Transit Gateway ID** | Chọn `Hub-TGW` đã tạo ở Bước 1. |

![](/images/2.transit-gateway/hinh10.png)
4.  Nhấp **Create Transit Gateway Route Table**.

![](/images/2.transit-gateway/hinh11.png)
### 2.2. Tạo Bảng Định Tuyến cho Spoke

1.  Nhấp **Create Transit Gateway Route Table** một lần nữa.
2.  Cấu hình:
    | Tham Số | Giá Trị |
    | :--- | :--- |
    | **Name tag** | `Spoke-Route-Table` |
    | **Transit Gateway ID** | Chọn `Hub-TGW`. |

![](/images/2.transit-gateway/hinh12.png)
3.  Nhấp **Create Transit Gateway Route Table**.
