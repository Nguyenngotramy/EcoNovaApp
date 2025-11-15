# AgriConnect - Ứng Dụng Bán Nông Sản Việt Nam

## Giới Thiệu
**Tên Đề Tài:** Xây dựng ứng dụng đa nền tảng bán nông sản Việt Nam  

AgriConnect là ứng dụng di động và web (iOS, Android, Web) kết nối trực tiếp nông dân Việt Nam với người tiêu dùng, giảm trung gian, thúc đẩy nông nghiệp bền vững. Ứng dụng tập trung vào nông sản Việt như rau củ, trái cây, gạo, cà phê, với tính năng minh bạch nguồn gốc (VietGAP, hữu cơ), giao hàng nhanh và AI hỗ trợ.  

**Công Nghệ Chính:**  
- Frontend: Flutter (đa nền tảng), Material Design.  
- Backend: Node.js/Express hoặc Laravel, MySQL/PostgreSQL.  
- Tích hợp: Google Maps, VNPAY/MoMo, Firebase (notification), AWS S3 (storage).  
- AI: OpenAI/Claude cho gợi ý và chatbot.  

**Ra Mắt Dự Kiến:** Q4/2025, mục tiêu 100.000 người dùng năm 2026.  

## Mục Tiêu Tổng Thể
- **Tăng doanh thu nông dân:** Giá minh bạch, tiếp cận thị trường nội địa/quốc tế.  
- **Đảm bảo chất lượng:** Chứng nhận VietGAP/Organic, theo dõi nguồn gốc (Đà Lạt, ĐBSCL).  
- **Cải thiện UX:** Tìm kiếm/lọc nhanh, thanh toán an toàn, theo dõi real-time.  
- **Hỗ trợ kinh tế số:** Giảm lãng phí, flash sale theo mùa (Tết, hè).  
- **Đối tượng:** Nông dân/hợp tác xã (seller), cá nhân/doanh nghiệp (buyer), shipper, admin.  
- **Phạm vi:** Tập trung Việt Nam, hỗ trợ đa ngôn ngữ (Việt/Anh).  
- **Tuân thủ:** Nghị định 15/2018/NĐ-CP, bảo mật HTTPS/JWT, tải trang <3 giây.  

## Stakeholders (Người Liên Quan)
Dưới đây là các persona chính và vai trò của họ:

| Persona/Role | Mô Tả | Mục Tiêu Với Hệ Thống |
|--------------|--------|-----------------------|
| **Người Mua (Buyer)** | Cá nhân, hộ gia đình, nhà hàng, siêu thị nhỏ/doanh nghiệp mua nông sản trực tiếp từ nông dân. | - Tìm kiếm/lọc sản phẩm dễ dàng.<br>- Tư vấn AI (sản phẩm, giá, dinh dưỡng).<br>- Thanh toán an toàn, theo dõi đơn real-time.<br>- Đánh giá sản phẩm/bán hàng. |
| **Người Giao Hàng (Shipper)** | Người đăng ký giao hàng trên app. | - Nhận/xử lý đơn tự động.<br>- Cập nhật trạng thái (GPS, ETA).<br>- Tối ưu tuyến đường bằng AI.<br>- Báo cáo vận hành. |
| **Người Bán (Seller)** | Nông dân hoặc hợp tác xã bán nông sản Việt Nam. | - Quản lý sản phẩm/đơn hàng.<br>- Cập nhật tồn kho.<br>- Xem báo cáo doanh thu.<br>- Livestream bán hàng. |
| **Quản Trị Hệ Thống (Admin)** | Người/nhóm quản lý toàn hệ thống. | - Quản lý người dùng/sản phẩm/đơn hàng.<br>- Giám sát giao hàng/thống kê.<br>- Xử lý khiếu nại/khuyến mãi. |

## Yêu Cầu Chức Năng (Functional Requirements)
Dưới đây là các chức năng chính từ góc nhìn người dùng. Mỗi yêu cầu có ID, tiêu đề, mô tả, công nghệ gợi ý và role liên quan.

### Chức Năng Cho Người Mua (Buyer - B-xx)
| Req. ID | Tiêu Đề | Mô Tả | Công Nghệ | Role |
|---------|---------|-------|-----------|------|
| B-01 | Đăng ký tài khoản | Đăng ký qua email/số ĐT/FB/Google, xác thực OTP. | OAuth 2.0, SMS Gateway (Twilio), JWT, bcrypt. | Buyer |
| B-02 | Đăng nhập và quản lý phiên | Lưu session, hỗ trợ multi-device, auto-logout. | JWT refresh, Redis, device fingerprint. | Buyer |
| B-03 | Quản lý hồ sơ cá nhân | Cập nhật tên, ảnh, ĐT, email, sinh nhật, giới tính. | RESTful API, AWS S3/Cloudinary, form validation. | Buyer |
| B-04 | Quản lý địa chỉ giao hàng | Thêm/sửa/xóa địa chỉ, đặt mặc định. | CRUD API, Google Maps autocomplete, GPS. | Buyer |
| B-05 | Tìm kiếm sản phẩm | Tìm theo tên/loại/vùng/giá/chứng nhận/mùa vụ, hỗ trợ voice. | ElasticSearch, Google Speech-to-Text, autocomplete. | Buyer |
| B-06 | Lọc và sắp xếp sản phẩm | Lọc theo giá/khoảng cách/đánh giá/chứng nhận. | Dynamic query, faceted search, multi-sorting. | Buyer |
| B-07 | Xem chi tiết sản phẩm | Xem giá/mô tả/hình/video/nguồn gốc/đánh giá. | Swiper.js gallery, HLS video, lazy loading. | Buyer |
| B-08 | Gợi ý sản phẩm bằng AI | Gợi ý dựa trên hành vi/xu hướng/mùa vụ. | ML Collaborative Filtering, Mixpanel tracking. | Buyer |
| B-09 | Giỏ hàng | Thêm/chỉnh sửa/xóa, kiểm tra tồn kho real-time. | Microservice, WebSocket, Redis/localStorage. | Buyer |
| B-10 | Quy trình thanh toán | Xác nhận đơn, chọn địa chỉ/thời gian, xem tổng tiền. | API thanh toán, tính phí vận chuyển. | Buyer |
| B-11 | Chọn phương thức thanh toán | COD, ví điện tử (Momo/ZaloPay/VNPay), QR. | VNPay/Momo SDK, VietQR. | Buyer |
| B-12 | Xác nhận đơn hàng | Tạo đơn sau thanh toán, gửi thông báo. | SendGrid/AWS SES, Firebase FCM. | Buyer |
| B-13 | Theo dõi đơn hàng | Theo dõi trạng thái/GPS real-time. | State machine, WebSocket, Google Maps. | Buyer |
| B-14 | Trò chuyện trực tiếp | Chat với seller hỏi sản phẩm/giá. | WebSocket/Socket.io, RabbitMQ. | Buyer |
| B-15 | Trợ lý ảo AI | Chatbot 24/7 gợi ý/trả lời FAQ. | OpenAI/Claude API, RAG. | Buyer |
| B-16 | Nhận hàng và xác nhận | Xác nhận bằng OTP/chữ ký/chụp ảnh. | OTP SMS, chữ ký điện tử. | Buyer |
| B-17 | Đánh giá sản phẩm | Đánh giá sản phẩm/seller/shipper (sao, bình luận, ảnh). | Microservice, AI sentiment analysis. | Buyer |
| B-18 | Khiếu nại và trả hàng | Gửi khiếu nại với ảnh/video, tạm giữ tiền. | Ticket system, file upload. | Buyer |
| B-19 | Quản lý hoàn tiền | Hoàn tiền vào ví/ngân hàng. | VNPay/Momo API, ví nội bộ. | Buyer |
| B-20 | Phiếu giảm giá | Sử dụng voucher/miễn phí ship. | Voucher engine, campaign management. | Buyer |
| B-21 | Lịch sử đơn hàng | Xem/lọc đơn cũ, xuất CSV/PDF. | Paginated API, filter/search. | Buyer |
| B-22 | Đặt lại đơn hàng | Sao chép đơn cũ, kiểm tra tồn kho/giá mới. | Copy logic, one-tap payment. | Buyer |
| B-23 | Danh sách yêu thích | Lưu sản phẩm, thông báo giảm giá/hết hàng. | CRUD API, price alert. | Buyer |
| B-24 | Yêu cầu B2B | Gửi báo giá số lượng lớn. | RFQ workflow, e-signature. | Buyer |
| B-25 | Quản lý thông báo | Nhận/bật tắt thông báo đa kênh. | Firebase/OneSignal, multi-channel. | Buyer |
| B-26 | Hỗ trợ đa ngôn ngữ | Chuyển Việt/Anh. | i18next, auto-detect. | Buyer |
| B-27 | Bảo mật tài khoản | 2FA, đổi mật khẩu, xem lịch sử đăng nhập. | TOTP/SMS, audit log. | Buyer |
| B-28 | Đặt trước theo mùa | Đặt trước với đặt cọc, dự báo AI. | Pre-order module, ML forecast. | Buyer |

### Chức Năng Cho Shipper (VC-xx)
| Req. ID | Tiêu Đề | Mô Tả | Công Nghệ | Role |
|---------|---------|-------|-----------|------|
| VC-01 | Tự động phân đơn | Phân đơn dựa vị trí/giá/đánh giá. | Routing algorithm, priority queue. | Shipper |
| VC-02 | Tính phí vận chuyển | Tính dựa khoảng cách/trọng lượng/loại hàng. | Google Maps API, dynamic pricing. | Shipper |
| VC-03 | Nhận xác nhận giao hàng | Nhận chi tiết đơn, xác nhận/từ chối. | Webhook, 5-min timeout. | Shipper |
| VC-04 | Cập nhật trạng thái | Cập nhật "nhận/đang giao/hoàn thành/thất bại". | Webhook, photo proof. | Shipper |
| VC-05 | Tích hợp GPS | Gửi vị trí real-time, tính ETA. | WebSocket, Mapbox. | Shipper |
| VC-06 | Bằng chứng giao hàng | Ảnh/chữ ký/OTP. | File upload, OTP verify. | Shipper |
| VC-07 | Xử lý COD | Thu tiền mặt, đối soát hàng ngày. | COD tracking, bank transfer. | Shipper |
| VC-08 | Vận chuyển trả hàng | Lấy hàng từ buyer giao về seller. | Reverse logistics API. | Shipper |
| VC-09 | Theo dõi hiệu suất | KPI giao hàng, xếp hạng. | Analytics dashboard, Chart.js. | Shipper |
| VC-10 | Thanh toán cho shipper | Hoa hồng hàng tuần/tháng. | Invoice generation, bank API. | Shipper |
| VC-11 | Xếp hạng shipper | Đánh giá từ buyer, cải thiện. | Rating aggregation. | Shipper |

### Chức Năng Cho Admin (AD-xx)
| Req. ID | Tiêu Đề | Mô Tả | Công Nghệ | Role |
|---------|---------|-------|-----------|------|
| AD-01 | Quản lý người dùng | CRUD users (buyer/seller/shipper). | Role-based API. | Admin |
| AD-02 | Quản lý shipper | Xem tiến độ/đánh giá, xóa shipper xấu. | Shipper API. | Admin |
| AD-03 | Giám sát sản phẩm | Duyệt/ẩn sản phẩm vi phạm. | Pending approval workflow. | Admin |
| AD-04 | Quản lý đơn hàng | Lọc/can thiệp đơn hàng. | Orders API. | Admin |
| AD-05 | Quản lý giao hàng | Theo dõi trạng thái, xử lý sự cố. | Realtime socket. | Admin |
| AD-06 | Thống kê doanh thu | Báo cáo theo thời gian/loại. | SQL aggregate, Chart.js. | Admin |
| AD-07 | Quản lý AI gợi ý | Bật/tắt, xem báo cáo tương tác. | AI module toggle. | Admin |
| AD-08 | Quản lý phản hồi | Phân loại/xử lý khiếu nại. | Feedback CRUD. | Admin |
| AD-09 | Quản lý banner | Tạo/quản lý quảng cáo/khuyến mãi. | Promotions API. | Admin |
| AD-10 | Quản lý thông báo | Gửi thông báo hệ thống. | FCM/Email service. | Admin |

### Chức Năng Cho Seller (SL-xx)
| Req. ID | Tiêu Đề | Mô Tả | Công Nghệ | Role |
|---------|---------|-------|-----------|------|
| SL-01 | Quản lý sản phẩm | CRUD sản phẩm, upload media, cảnh báo tồn kho. | RESTful API, AWS S3, WebSocket. | Seller |
| SL-02 | Xử lý đơn hàng | Xác nhận/hủy đơn, in nhãn, theo dõi logistics. | GHTK API, PDF.js, FSM. | Seller |
| SL-03 | Báo cáo | Doanh thu/sản phẩm bán chạy, sentiment analysis. | Chart.js, NLTK/Hugging Face. | Seller |
| SL-04 | Khuyến mãi | Tạo voucher/flash sale theo mùa. | Rule engine, Google Calendar. | Seller |
| SL-05 | Livestream bán hàng | Phát trực tiếp, chat/đặt hàng real-time. | Agora.io RTMP, Socket.io. | Seller |
| SL-06 | Quản lý đối tác | Kết nối phân phối, theo dõi hiệu suất. | Neo4j graph DB, KPI dashboard. | Seller |

## Cài Đặt & Chạy Project
1. **Clone Repo:**  
   ```
   git clone https://github.com/your-username/agriconnect.git
   cd agriconnect
   ```

2. **Cài Dependencies:**  
   - Flutter: `flutter pub get`  
   - Backend (nếu có): `npm install` hoặc `composer install`

3. **Chạy App:**  
   - Mobile: `flutter run` (iOS/Android)  
   - Web: `flutter run -d chrome`  
   - Backend: `npm start` hoặc `php artisan serve`

4. **Môi Trường Phát Triển:**  
   - Flutter SDK >= 3.10  
   - Node.js 18+ hoặc PHP 8+  
   - MySQL 8.0+ (import schema từ `/database/schema.sql`)  

## Cấu Trúc Project
```
agriconnect/
├── lib/
│   ├── models/          # Models từ DB (User, Product, Order...)
│   ├── screens/         # UI screens (Home, Cart, Profile...)
│   ├── services/        # API services (Auth, Payment...)
│   └── main.dart        # Entry point
├── database/            # Schema SQL
├── docs/                # Tài liệu (SRS, ERD)
└── README.md            # File này
```

## Đóng Góp
- Fork repo và tạo Pull Request.  
- Theo chuẩn: Conventional Commits (feat:, fix:, docs:).  
- Liên hệ: [email@example.com] hoặc issue trên GitHub.  

## License
MIT License - Xem file `LICENSE`.  

**Cảm ơn bạn đã quan tâm AgriConnect! 🌾🇻🇳**  
*(Cập nhật: 15/11/2025)*
