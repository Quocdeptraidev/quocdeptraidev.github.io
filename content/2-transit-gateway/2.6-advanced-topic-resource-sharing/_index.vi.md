---
title: "Chủ đề nâng cao (Tùy chọn): Chia Sẻ Tài Nguyên"
date: "2025-07-12"
weight: 6
menu : "main"
chapter : false
pre : " <b> 2.6 </b> "
---

Nếu bạn muốn chia sẻ Transit Gateway này với các tài khoản AWS khác trong cùng một tổ chức (AWS Organization), bạn có thể sử dụng **AWS Resource Access Manager (RAM)**.

1.  Mở dịch vụ **AWS Resource Access Manager (RAM)**.
2.  Nhấp **Create resource share**.
3.  Chọn `Transit Gateways` làm loại tài nguyên và chọn `Hub-TGW`.
4.  Trong **Principals**, nhập ID tài khoản AWS hoặc OU của tổ chức bạn muốn chia sẻ.
