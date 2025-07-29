---
title: "Hiệu suất Transit Gateway"
date: "`r Sys.Date()`"
menu : "main"
weight: 3
chapter : false
pre : " <b> 6.2.3 </b> "
---

### 2.3 Hiệu suất Transit Gateway

Việc giám sát hiệu suất Transit Gateway là rất quan trọng để đảm bảo rằng nó không trở thành điểm nghẽn trong kiến trúc mạng của bạn. Transit Gateway xử lý lưu lượng liên-VPC và liên-tài khoản, vì vậy việc theo dõi các chỉ số như `BytesIn`, `BytesOut`, `PacketsIn`, và `PacketsOut` giúp xác định sớm các vấn đề về hiệu suất, tắc nghẽn hoặc các mẫu lưu lượng bất thường. Điều này đảm bảo rằng các ứng dụng của bạn có thể giao tiếp hiệu quả và duy trì hiệu suất cao.

#### Giám sát các Chỉ số Transit Gateway
