---
title: "Tạo Spoke VPCs (Production & Development)"
date: "2025-07-13"
menu : "main"
weight : 4
chapter : false
pre : " <b> 4. </b> "
---
Trong chương này, chúng ta sẽ đi sâu vào việc thiết lập và cấu hình các Spoke VPCs, một thành phần thiết yếu trong kiến trúc mạng Hub-and-Spoke trên AWS.

**Nội dung chính:**

- **[Tạo Spoke VPCs (4.1)](4.1-create-spoke-vpcs/)**: Hướng dẫn chi tiết cách tạo các VPC riêng biệt cho môi trường Production và Development.
- **[Cấu hình Route Tables (4.2)](4.2-configure-route-tables/)**: Thiết lập bảng định tuyến cho từng VPC để kiểm soát luồng traffic.
- **[Kết nối với Transit Gateway (4.3)](4.3-attach-to-transit-gateway/)**: Gắn các Spoke VPCs vào Transit Gateway để kết nối với Hub VPC.
- **[Cấu hình Security Groups (4.4)](4.4-configure-security-groups/)**: Định nghĩa các quy tắc tường lửa để bảo vệ tài nguyên trong từng VPC.
- **[Tạo Test Instances (4.5)](4.5-create-test-instances/)**: Khởi chạy các máy ảo EC2 để kiểm tra kết nối.
- **[Cập nhật Route Tables (4.6)](4.6-update-route-tables/)**: Thêm các route cần thiết để cho phép giao tiếp giữa các VPC và truy cập internet.
- **[Kiểm tra kết nối (4.7)](4.7-testing-connectivity/)**: Xác minh rằng tất cả các thành phần mạng hoạt động chính xác.
- **[Cấu hình nâng cao (4.8)](4.8-advanced-configuration/)**: Tùy chọn cấu hình Network ACLs và các thiết lập khác.
- **[Các bước tiếp theo (4.9)](4.9-next-steps/)**: Giới thiệu các chủ đề sẽ được đề cập trong chương tiếp theo.
