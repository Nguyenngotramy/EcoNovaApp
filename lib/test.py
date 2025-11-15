import os

# Nội dung các file (hardcode từ schema và models)
FILE_CONTENTS = {
    # enums.dart
    'lib/models/enums.dart': '''// Enums chung cho tất cả models, dựa trên ENUM trong SQL
import 'package:flutter/foundation.dart';

/// Enum cho role người dùng
enum UserRole { buyer, seller, shipper, admin }

/// Enum cho giới tính
enum Gender { male, female, other }

/// Enum cho loại địa chỉ
enum AddressType { home, office, other }

/// Enum cho mùa vụ thu hoạch
enum HarvestSeason { spring, summer, fall, winter, yearRound }

/// Enum cho trạng thái sản phẩm
enum ProductStatus { pending, active, inactive, rejected }

/// Enum cho trạng thái đơn hàng
enum OrderStatus { pending, confirmed, preparing, shipping, delivered, completed, cancelled, refunded }

/// Enum cho phương thức thanh toán
enum PaymentMethod { cod, momo, zaloPay, vnpay, bankTransfer, qrCode }

/// Enum cho trạng thái thanh toán
enum PaymentStatus { pending, processing, completed, failed, refunded }

/// Enum cho loại chứng nhận sản phẩm
enum CertType { vietGAP, organic, globalGAP, other }

/// Enum cho trạng thái vận chuyển
enum ShipmentStatus { pending, accepted, pickedUp, inTransit, delivered, failed, returned }

/// Enum cho trạng thái tracking
enum TrackingStatus { pickedUp, inTransit, nearDestination, delivered }

/// Enum cho loại voucher
enum VoucherType { percentage, fixed, freeShipping }

/// Enum cho loại thông báo
enum NotificationType { order, promotion, message, system, priceAlert }

/// Enum cho loại khiếu nại
enum ComplaintType { wrongProduct, damaged, lateDelivery, missingItems, other }

/// Enum cho trạng thái khiếu nại
enum ComplaintStatus { pending, investigating, resolved, rejected }

/// Enum cho phương thức hoàn tiền
enum RefundMethod { wallet, bank, originalPayment }

/// Enum cho trạng thái hoàn tiền
enum RefundStatus { pending, processing, completed, failed }

/// Enum cho trạng thái pre-order
enum PreOrderStatus { pending, confirmed, ready, completed, cancelled }

/// Enum cho trạng thái livestream
enum LivestreamStatus { scheduled, live, ended, cancelled }''',

    # user_management/user.dart
    'lib/models/user_management/user.dart': '''import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String email;
  final String phone;
  final String passwordHash; // Không lưu plain text trong app
  final UserRole role;
  final String fullName;
  final String? avatarUrl;
  final DateTime? birthDate;
  final Gender? gender;
  final bool isVerified;
  final bool twoFactorEnabled;
  final String? twoFactorSecret;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.email,
    required this.phone,
    required this.passwordHash,
    required this.role,
    required this.fullName,
    this.avatarUrl,
    this.birthDate,
    this.gender,
    required this.isVerified,
    required this.twoFactorEnabled,
    this.twoFactorSecret,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}''',

    # user_management/address.dart
    'lib/models/user_management/address.dart': '''import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  final int id;
  final int userId;
  final String addressLine;
  final String? ward;
  final String? district;
  final String? city;
  final String province;
  final double? latitude;
  final double? longitude;
  final bool isDefault;
  final AddressType addressType;
  final DateTime createdAt;

  Address({
    required this.id,
    required this.userId,
    required this.addressLine,
    this.ward,
    this.district,
    this.city,
    required this.province,
    this.latitude,
    this.longitude,
    required this.isDefault,
    required this.addressType,
    required this.createdAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}''',

    # user_management/login_history.dart
    'lib/models/user_management/login_history.dart': '''import 'package:json_annotation/json_annotation.dart';

part 'login_history.g.dart';

@JsonSerializable()
class LoginHistory {
  final int id;
  final int userId;
  final String? ipAddress;
  final String? userAgent;
  final String? deviceFingerprint;
  final DateTime loginAt;

  LoginHistory({
    required this.id,
    required this.userId,
    this.ipAddress,
    this.userAgent,
    this.deviceFingerprint,
    required this.loginAt,
  });

  factory LoginHistory.fromJson(Map<String, dynamic> json) => _$LoginHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$LoginHistoryToJson(this);
}''',

    # sellers_products/seller.dart
    'lib/models/sellers_products/seller.dart': '''import 'package:json_annotation/json_annotation.dart';

part 'seller.g.dart';

@JsonSerializable()
class Seller {
  final int id;
  final int userId;
  final String farmName;
  final String? businessLicense;
  final String? taxCode;
  final String? description;
  final bool isVerified;
  final double ratingAvg;
  final int totalReviews;
  final DateTime createdAt;

  Seller({
    required this.id,
    required this.userId,
    required this.farmName,
    this.businessLicense,
    this.taxCode,
    this.description,
    required this.isVerified,
    required this.ratingAvg,
    required this.totalReviews,
    required this.createdAt,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);
  Map<String, dynamic> toJson() => _$SellerToJson(this);
}''',

    # sellers_products/category.dart
    'lib/models/sellers_products/category.dart': '''import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  final int id;
  final String name;
  final String slug;
  final int? parentId;
  final int sortOrder;
  final DateTime createdAt;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    this.parentId,
    required this.sortOrder,
    required this.createdAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}''',

    # sellers_products/product.dart
    'lib/models/sellers_products/product.dart': '''import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int id;
  final int sellerId;
  final int categoryId;
  final String name;
  final String? description;
  final double price;
  final int stockQuantity;
  final String unit;
  final String? originProvince;
  final HarvestSeason harvestSeason;
  final String? storageInstruction;
  final ProductStatus status;
  final int viewCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.sellerId,
    required this.categoryId,
    required this.name,
    this.description,
    required this.price,
    required this.stockQuantity,
    required this.unit,
    this.originProvince,
    required this.harvestSeason,
    this.storageInstruction,
    required this.status,
    required this.viewCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}''',

    # sellers_products/product_image.dart
    'lib/models/sellers_products/product_image.dart': '''import 'package:json_annotation/json_annotation.dart';

part 'product_image.g.dart';

@JsonSerializable()
class ProductImage {
  final int id;
  final int productId;
  final String? imageUrl;
  final String? videoUrl;
  final bool isPrimary;
  final int sortOrder;

  ProductImage({
    required this.id,
    required this.productId,
    this.imageUrl,
    this.videoUrl,
    required this.isPrimary,
    required this.sortOrder,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) => _$ProductImageFromJson(json);
  Map<String, dynamic> toJson() => _$ProductImageToJson(this);
}''',

    # sellers_products/product_certification.dart
    'lib/models/sellers_products/product_certification.dart': '''import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'product_certification.g.dart';

@JsonSerializable()
class ProductCertification {
  final int id;
  final int productId;
  final CertType certType;
  final String? certNumber;
  final String? certUrl;
  final DateTime? validFrom;
  final DateTime? validTo;

  ProductCertification({
    required this.id,
    required this.productId,
    required this.certType,
    this.certNumber,
    this.certUrl,
    this.validFrom,
    this.validTo,
  });

  factory ProductCertification.fromJson(Map<String, dynamic> json) => _$ProductCertificationFromJson(json);
  Map<String, dynamic> toJson() => _$ProductCertificationToJson(this);
}''',

    # orders_payments/order.dart
    'lib/models/orders_payments/order.dart': '''import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  final int id;
  final String orderNumber;
  final int buyerId;
  final int sellerId;
  final int shippingAddressId;
  final OrderStatus status;
  final double subtotal;
  final double shippingFee;
  final double discountAmount;
  final double totalAmount;
  final String? buyerNote;
  final DateTime createdAt;
  final DateTime updatedAt;

  Order({
    required this.id,
    required this.orderNumber,
    required this.buyerId,
    required this.sellerId,
    required this.shippingAddressId,
    required this.status,
    required this.subtotal,
    required this.shippingFee,
    required this.discountAmount,
    required this.totalAmount,
    this.buyerNote,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}''',

    # orders_payments/order_item.dart
    'lib/models/orders_payments/order_item.dart': '''import 'package:json_annotation/json_annotation.dart';

part 'order_item.g.dart';

@JsonSerializable()
class OrderItem {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final double unitPrice;
  final double subtotal;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.unitPrice,
    required this.subtotal,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}''',

    # orders_payments/order_status_history.dart
    'lib/models/orders_payments/order_status_history.dart': '''import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'order_status_history.g.dart';

@JsonSerializable()
class OrderStatusHistory {
  final int id;
  final int orderId;
  final OrderStatus status;
  final String? note;
  final int? updatedBy;
  final DateTime createdAt;

  OrderStatusHistory({
    required this.id,
    required this.orderId,
    required this.status,
    this.note,
    this.updatedBy,
    required this.createdAt,
  });

  factory OrderStatusHistory.fromJson(Map<String, dynamic> json) => _$OrderStatusHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$OrderStatusHistoryToJson(this);
}''',

    # orders_payments/payment.dart
    'lib/models/orders_payments/payment.dart': '''import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'payment.g.dart';

@JsonSerializable()
class Payment {
  final int id;
  final int orderId;
  final PaymentMethod paymentMethod;
  final PaymentStatus status;
  final double amount;
  final String? transactionId;
  @JsonKey(name: 'payment_data')
  final Map<String, dynamic>? paymentData; // JSON từ SQL
  final DateTime? paidAt;
  final DateTime createdAt;

  Payment({
    required this.id,
    required this.orderId,
    required this.paymentMethod,
    required this.status,
    required this.amount,
    this.transactionId,
    this.paymentData,
    this.paidAt,
    required this.createdAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}''',

    # shipping/shipper.dart
    'lib/models/shipping/shipper.dart': '''import 'package:json_annotation/json_annotation.dart';

part 'shipper.g.dart';

@JsonSerializable()
class Shipper {
  final int id;
  final int userId;
  final String? vehicleType;
  final String? licensePlate;
  final String? idCardNumber;
  final bool isVerified;
  final bool isActive;
  final double ratingAvg;
  final int totalDeliveries;
  final int successDeliveries;
  final DateTime createdAt;

  Shipper({
    required this.id,
    required this.userId,
    this.vehicleType,
    this.licensePlate,
    this.idCardNumber,
    required this.isVerified,
    required this.isActive,
    required this.ratingAvg,
    required this.totalDeliveries,
    required this.successDeliveries,
    required this.createdAt,
  });

  factory Shipper.fromJson(Map<String, dynamic> json) => _$ShipperFromJson(json);
  Map<String, dynamic> toJson() => _$ShipperToJson(this);
}''',

    # shipping/shipment.dart
    'lib/models/shipping/shipment.dart': '''import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'shipment.g.dart';

@JsonSerializable()
class Shipment {
  final int id;
  final int orderId;
  final int? shipperId;
  final ShipmentStatus status;
  final double shippingFee;
  final String pickupAddress;
  final String deliveryAddress;
  @JsonKey(name: 'pickup_lat')
  final double? pickupLat;
  @JsonKey(name: 'pickup_lng')
  final double? pickupLng;
  @JsonKey(name: 'delivery_lat')
  final double? deliveryLat;
  @JsonKey(name: 'delivery_lng')
  final double? deliveryLng;
  @JsonKey(name: 'pickup_time')
  final DateTime? pickupTime;
  @JsonKey(name: 'estimated_delivery')
  final DateTime? estimatedDelivery;
  @JsonKey(name: 'delivered_at')
  final DateTime? deliveredAt;
  @JsonKey(name: 'delivery_proof_url')
  final String? deliveryProofUrl;
  @JsonKey(name: 'delivery_otp')
  final String? deliveryOtp;
  @JsonKey(name: 'failure_reason')
  final String? failureReason;
  final DateTime createdAt;

  Shipment({
    required this.id,
    required this.orderId,
    this.shipperId,
    required this.status,
    required this.shippingFee,
    required this.pickupAddress,
    required this.deliveryAddress,
    this.pickupLat,
    this.pickupLng,
    this.deliveryLat,
    this.deliveryLng,
    this.pickupTime,
    this.estimatedDelivery,
    this.deliveredAt,
    this.deliveryProofUrl,
    this.deliveryOtp,
    this.failureReason,
    required this.createdAt,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) => _$ShipmentFromJson(json);
  Map<String, dynamic> toJson() => _$ShipmentToJson(this);
}''',

    # shipping/shipment_tracking.dart
    'lib/models/shipping/shipment_tracking.dart': '''import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'shipment_tracking.g.dart';

@JsonSerializable()
class ShipmentTracking {
  final int id;
  final int shipmentId;
  final double latitude;
  final double longitude;
  final TrackingStatus status;
  final DateTime createdAt;

  ShipmentTracking({
    required this.id,
    required this.shipmentId,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.createdAt,
  });

  factory ShipmentTracking.fromJson(Map<String, dynamic> json) => _$ShipmentTrackingFromJson(json);
  Map<String, dynamic> toJson() => _$ShipmentTrackingToJson(this);
}''',

    # reviews/review.dart
    'lib/models/reviews/review.dart': '''import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable()
class Review {
  final int id;
  final int productId;
  final int orderId;
  final int userId;
  @JsonKey(name: 'product_rating')
  final int? productRating;
  @JsonKey(name: 'seller_rating')
  final int? sellerRating;
  @JsonKey(name: 'shipper_rating')
  final int? shipperRating;
  final String? comment;
  @JsonKey(name: 'images_url')
  final List<String>? imagesUrl; // JSON array từ SQL
  @JsonKey(name: 'is_verified_purchase')
  final bool isVerifiedPurchase;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.productId,
    required this.orderId,
    required this.userId,
    this.productRating,
    this.sellerRating,
    this.shipperRating,
    this.comment,
    this.imagesUrl,
    required this.isVerifiedPurchase,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}''',

    # cart_wishlist/cart_item.dart
    'lib/models/cart_wishlist/cart_item.dart': '''import 'package:json_annotation/json_annotation.dart';

part 'cart_item.g.dart';

@JsonSerializable()
class CartItem {
  final int id;
  final int userId;
  final int productId;
  final int quantity;
  final DateTime createdAt;
  final DateTime updatedAt;

  CartItem({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}''',

    # cart_wishlist/wishlist.dart
    'lib/models/cart_wishlist/wishlist.dart': '''import 'package:json_annotation/json_annotation.dart';

part 'wishlist.g.dart';

@JsonSerializable()
class Wishlist {
  final int id;
  final int userId;
  final int productId;
  final DateTime createdAt;

  Wishlist({
    required this.id,
    required this.userId,
    required this.productId,
    required this.createdAt,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) => _$WishlistFromJson(json);
  Map<String, dynamic> toJson() => _$WishlistToJson(this);
}''',

    # vouchers/voucher.dart
    'lib/models/vouchers/voucher.dart': '''import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'voucher.g.dart';

@JsonSerializable()
class Voucher {
  final int id;
  final String code;
  final VoucherType type;
  @JsonKey(name: 'discount_value')
  final double discountValue;
  @JsonKey(name: 'min_order_value')
  final double minOrderValue;
  @JsonKey(name: 'max_discount')
  final double? maxDiscount;
  @JsonKey(name: 'usage_limit')
  final int? usageLimit;
  @JsonKey(name: 'used_count')
  final int usedCount;
  @JsonKey(name: 'valid_from')
  final DateTime validFrom;
  @JsonKey(name: 'valid_to')
  final DateTime validTo;
  @JsonKey(name: 'is_active')
  final bool isActive;
  final DateTime createdAt;

  Voucher({
    required this.id,
    required this.code,
    required this.type,
    required this.discountValue,
    required this.minOrderValue,
    this.maxDiscount,
    this.usageLimit,
    required this.usedCount,
    required this.validFrom,
    required this.validTo,
    required this.isActive,
    required this.createdAt,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) => _$VoucherFromJson(json);
  Map<String, dynamic> toJson() => _$VoucherToJson(this);
}''',

    # vouchers/voucher_usage.dart
    'lib/models/vouchers/voucher_usage.dart': '''import 'package:json_annotation/json_annotation.dart';

part 'voucher_usage.g.dart';

@JsonSerializable()
class VoucherUsage {
  final int id;
  final int voucherId;
  final int userId;
  final int orderId;
  @JsonKey(name: 'used_at')
  final DateTime usedAt;

  VoucherUsage({
    required this.id,
    required this.voucherId,
    required this.userId,
    required this.orderId,
    required this.usedAt,
  });

  factory VoucherUsage.fromJson(Map<String, dynamic> json) => _$VoucherUsageFromJson(json);
  Map<String, dynamic> toJson() => _$VoucherUsageToJson(this);
}''',

    # communication/message.dart
    'lib/models/communication/message.dart': '''import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final int id;
  final int senderId;
  final int receiverId;
  final String message;
  @JsonKey(name: 'attachment_url')
  final String? attachmentUrl;
  @JsonKey(name: 'is_read')
  final bool isRead;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    this.attachmentUrl,
    required this.isRead,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}''',

    # communication/notification.dart
    'lib/models/communication/notification.dart': '''import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notification {
  final int id;
  final int userId;
  final NotificationType type;
  final String title;
  final String? content;
  @JsonKey(name: 'data_json')
  final Map<String, dynamic>? dataJson; // JSON từ SQL
  @JsonKey(name: 'is_read')
  final bool isRead;
  final DateTime createdAt;

  Notification({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    this.content,
    this.dataJson,
    required this.isRead,
    required this.createdAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}''',

    # complaints_refunds/complaint.dart
    'lib/models/complaints_refunds/complaint.dart': '''import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'complaint.g.dart';

@JsonSerializable()
class Complaint {
  final int id;
  final int orderId;
  final int userId;
  final ComplaintType type;
  final String description;
  @JsonKey(name: 'evidence_urls')
  final List<String>? evidenceUrls; // JSON array từ SQL
  final ComplaintStatus status;
  @JsonKey(name: 'admin_note')
  final String? adminNote;
  final DateTime createdAt;
  @JsonKey(name: 'resolved_at')
  final DateTime? resolvedAt;

  Complaint({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.type,
    required this.description,
    this.evidenceUrls,
    required this.status,
    this.adminNote,
    required this.createdAt,
    this.resolvedAt,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) => _$ComplaintFromJson(json);
  Map<String, dynamic> toJson() => _$ComplaintToJson(this);
}''',

    # complaints_refunds/refund.dart
    'lib/models/complaints_refunds/refund.dart': '''import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'refund.g.dart';

@JsonSerializable()
class Refund {
  final int id;
  final int complaintId;
  final int orderId;
  @JsonKey(name: 'refund_amount')
  final double refundAmount;
  final RefundMethod refundMethod;
  final RefundStatus status;
  @JsonKey(name: 'transaction_id')
  final String? transactionId;
  final DateTime createdAt;
  @JsonKey(name: 'completed_at')
  final DateTime? completedAt;

  Refund({
    required this.id,
    required this.complaintId,
    required this.orderId,
    required this.refundAmount,
    required this.refundMethod,
    required this.status,
    this.transactionId,
    required this.createdAt,
    this.completedAt,
  });

  factory Refund.fromJson(Map<String, dynamic> json) => _$RefundFromJson(json);
  Map<String, dynamic> toJson() => _$RefundToJson(this);
}''',

    # preorder_livestream/pre_order.dart
    'lib/models/preorder_livestream/pre_order.dart': '''import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'pre_order.g.dart';

@JsonSerializable()
class PreOrder {
  final int id;
  final int productId;
  final int userId;
  final int quantity;
  @JsonKey(name: 'deposit_amount')
  final double depositAmount;
  @JsonKey(name: 'expected_harvest')
  final DateTime expectedHarvest;
  final PreOrderStatus status;
  final DateTime createdAt;

  PreOrder({
    required this.id,
    required this.productId,
    required this.userId,
    required this.quantity,
    required this.depositAmount,
    required this.expectedHarvest,
    required this.status,
    required this.createdAt,
  });

  factory PreOrder.fromJson(Map<String, dynamic> json) => _$PreOrderFromJson(json);
  Map<String, dynamic> toJson() => _$PreOrderToJson(this);
}''',

    # preorder_livestream/livestream.dart
    'lib/models/preorder_livestream/livestream.dart': '''import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'livestream.g.dart';

@JsonSerializable()
class Livestream {
  final int id;
  final int sellerId;
  final String title;
  final String? description;
  @JsonKey(name: 'stream_url')
  final String? streamUrl;
  @JsonKey(name: 'thumbnail_url')
  final String? thumbnailUrl;
  @JsonKey(name: 'scheduled_at')
  final DateTime scheduledAt;
  @JsonKey(name: 'started_at')
  final DateTime? startedAt;
  @JsonKey(name: 'ended_at')
  final DateTime? endedAt;
  @JsonKey(name: 'viewer_count')
  final int viewerCount;
  final LivestreamStatus status;
  final DateTime createdAt;

  Livestream({
    required this.id,
    required this.sellerId,
    required this.title,
    this.description,
    this.streamUrl,
    this.thumbnailUrl,
    required this.scheduledAt,
    this.startedAt,
    this.endedAt,
    required this.viewerCount,
    required this.status,
    required this.createdAt,
  });

  factory Livestream.fromJson(Map<String, dynamic> json) => _$LivestreamFromJson(json);
  Map<String, dynamic> toJson() => _$LivestreamToJson(this);
}''',

    # ai_analytics/ai_recommendation.dart
    'lib/models/ai_analytics/ai_recommendation.dart': '''import 'package:json_annotation/json_annotation.dart';

part 'ai_recommendation.g.dart';

@JsonSerializable()
class AiRecommendation {
  final int id;
  final int userId;
  final int productId;
  final double score;
  final String? reason;
  final DateTime createdAt;

  AiRecommendation({
    required this.id,
    required this.userId,
    required this.productId,
    required this.score,
    this.reason,
    required this.createdAt,
  });

  factory AiRecommendation.fromJson(Map<String, dynamic> json) => _$AiRecommendationFromJson(json);
  Map<String, dynamic> toJson() => _$AiRecommendationToJson(this);
}''',

    # views/product_with_seller.dart
    'lib/models/views/product_with_seller.dart': '''import 'package:json_annotation/json_annotation.dart';
import '../sellers_products/product.dart';

part 'product_with_seller.g.dart';

@JsonSerializable()
class ProductWithSeller {
  final Product product;
  final String farmName;
  @JsonKey(name: 'seller_rating')
  final double sellerRating;
  @JsonKey(name: 'seller_name')
  final String sellerName;
  @JsonKey(name: 'seller_phone')
  final String sellerPhone;
  @JsonKey(name: 'category_name')
  final String categoryName;

  ProductWithSeller({
    required this.product,
    required this.farmName,
    required this.sellerRating,
    required this.sellerName,
    required this.sellerPhone,
    required this.categoryName,
  });

  factory ProductWithSeller.fromJson(Map<String, dynamic> json) => _$ProductWithSellerFromJson(json);
  Map<String, dynamic> toJson() => _$ProductWithSellerToJson(this);
}''',

    # views/order_summary.dart
    'lib/models/views/order_summary.dart': '''import 'package:json_annotation/json_annotation.dart';
import '../orders_payments/order.dart';
import '../../enums.dart'; // Import enums

part 'order_summary.g.dart';

@JsonSerializable()
class OrderSummary {
  final Order order;
  @JsonKey(name: 'buyer_name')
  final String buyerName;
  @JsonKey(name: 'buyer_email')
  final String buyerEmail;
  @JsonKey(name: 'seller_farm')
  final String sellerFarm;
  @JsonKey(name: 'total_items')
  final int totalItems;
  @JsonKey(name: 'payment_status')
  final PaymentStatus? paymentStatus;
  @JsonKey(name: 'shipping_status')
  final ShipmentStatus? shippingStatus;

  OrderSummary({
    required this.order,
    required this.buyerName,
    required this.buyerEmail,
    required this.sellerFarm,
    required this.totalItems,
    this.paymentStatus,
    this.shippingStatus,
  });

  factory OrderSummary.fromJson(Map<String, dynamic> json) => _$OrderSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$OrderSummaryToJson(this);
}'''
}

def create_folder_structure():
    # Tạo thư mục lib/models
    os.makedirs('lib/models', exist_ok=True)

    # Tạo các thư mục con
    subfolders = [
        'lib/models/user_management',
        'lib/models/sellers_products',
        'lib/models/orders_payments',
        'lib/models/shipping',
        'lib/models/reviews',
        'lib/models/cart_wishlist',
        'lib/models/vouchers',
        'lib/models/communication',
        'lib/models/complaints_refunds',
        'lib/models/preorder_livestream',
        'lib/models/ai_analytics',
        'lib/models/views'
    ]

    for folder in subfolders:
        os.makedirs(folder, exist_ok=True)

    # Tạo các file với nội dung
    for filepath, content in FILE_CONTENTS.items():
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Đã tạo file: {filepath}")

    print("Hoàn thành! Cấu trúc thư mục models đã được tạo trong lib/.")

if __name__ == "__main__":
    create_folder_structure()