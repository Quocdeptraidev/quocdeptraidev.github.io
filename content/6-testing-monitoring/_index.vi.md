---
title: "Kiểm thử và Giám sát"
date: "`r Sys.Date()`"
weight: 6
chapter: false
pre: "<b> 6. </b>"
---


Trong chương này, chúng ta sẽ thực hiện kiểm thử toàn diện và thiết lập hệ thống giám sát cho kiến trúc hub-and-spoke.

{{% notice info %}}
Chương này cung cấp hướng dẫn chi tiết về cách kiểm thử kết nối, hiệu suất, bảo mật, và khả năng chuyển đổi dự phòng của kiến trúc mạng hub-and-spoke. Đồng thời, nó cũng hướng dẫn thiết lập hệ thống giám sát toàn diện bằng CloudWatch để đảm bảo hoạt động ổn định và hiệu quả.
{{% /notice %}}

## Mục lục

* [6.1 Kiểm Tra Kết Nối](6.1-connection-testing/)
    * [6.1.1 Kiểm Tra Kết Nối Cơ Bản](6.1-connection-testing/6.1.1-basic-connection-testing/)
    * [6.1.2 Kiểm Tra Kết Nối Nâng Cao](6.1-connection-testing/6.1.2-advanced-connection-testing/)
    * [6.1.3 Kiểm Tra Kết Nối DNS](6.1-connection-testing/6.1.3-dns-resolution-testing/)
* [6.2 Kiểm Tra Hiệu Năng](6.2-performance-testing/)
    * [6.2.1 Kiểm Tra Độ Trễ Mạng](6.2-performance-testing/6.2.1-network-latency-testing/)
    * [6.2.2 Kiểm Tra Băng Thông](6.2-performance-testing/6.2.2-bandwidth-testing/)
    * [6.2.3 Hiệu Năng Transit Gateway](6.2-performance-testing/6.2.3-transit-gateway-performance/)
* [6.3 Kiểm Tra Bảo Mật](6.3-security-testing/)
    * [6.3.1 Kiểm Tra Nhóm Bảo Mật (Security Group)](6.3-security-testing/6.3.1-security-group-testing/)
    * [6.3.2 Kiểm Tra ACL Mạng (Network ACL)](6.3-security-testing/6.3.2-network-acl-testing/)
    * [6.3.3 Phân Tích VPC Flow Log](6.3-security-testing/6.3.3-vpc-flow-log-analysis/)
* [6.4 Kiểm Tra Chuyển Đổi Dự Phòng (Failover)](6.4-failover-testing/)
* [6.5 Thiết Lập Giám Sát](6.5-monitoring-setup/)
    * [6.5.1 Bảng Điều Khiển CloudWatch](6.5-monitoring-setup/6.5.1-cloudwatch-dashboard/)
* [6.6 Theo Dõi Chi Phí](6.6-monitoring-costs/)
* [6.7 Xử Lý Sự Cố Thường Gặp](6.7-common-troubleshooting/)
* [6.8 Bước Tiếp Theo](6.8-next-steps/)
* [6.9 Tài Liệu Tham Khảo](6.9-references/)

