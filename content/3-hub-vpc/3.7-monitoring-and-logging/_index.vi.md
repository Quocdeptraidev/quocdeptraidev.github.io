---
title: "Giám Sát và Ghi Log (VPC Flow Logs)"
date :  "`r Sys.Date()`" 
menu : "main"
weight : 7
chapter : false
pre : " <b> 3.7 </b> "
---


## Bước 7: Giám Sát và Ghi Log (VPC Flow Logs)

Để giám sát lưu lượng mạng trong Hub VPC, chúng ta sẽ bật VPC Flow Logs.

### 7.1 Bật VPC Flow Logs

1.  Trong VPC Console, chọn **Your VPCs**.
2.  Chọn **Hub-VPC**.
3.  Chọn tab **Flow Logs**, nhấp **Create flow log**.
4.  Cấu hình:
    | Tham Số | Giá Trị |
    | :--- | :--- |
    | **Name** | `hub-vpc-flow-log` |
    | **Filter** | `All` (Ghi lại cả traffic được chấp nhận và từ chối). |
    | **Maximum aggregation interval** | `10 minutes` |
    | **Destination** | `Send to CloudWatch Logs` |
    | **Destination log group** | Tạo một log group mới, ví dụ: `/aws/vpc-flow-logs/hub-vpc` |
    | **Log record format** | `AWS default format` |
5.  Nhấp **Create flow log**.

### 7.2 Theo Dõi Metrics trên CloudWatch

Transit Gateway tự động gửi các chỉ số về CloudWatch:
- **BytesIn/BytesOut**: Lưu lượng dữ liệu truyền qua.
- **PacketsIn/PacketsOut**: Số lượng gói tin.
- **PacketDropCount**: Số lượng gói tin bị rớt do không có route hoặc do ACL.
