// Enums chung cho tất cả models, dựa trên ENUM trong SQL
import 'package:flutter/foundation.dart';
// lib/models/enums.dart
// Enums for Agricultural E-commerce Platform
// Mapped to MySQL ENUM types in database

/// User role in the system
enum UserRole {
  buyer,
  seller,
  shipper,
  admin,
}

/// User gender
enum Gender {
  male,
  female,
  other,
}

/// Address type classification
enum AddressType {
  home,
  office,
  other,
}

/// Harvest season for products
enum HarvestSeason {
  spring,
  summer,
  fall,
  winter,
  yearRound,
}

/// Product listing status
enum ProductStatus {
  pending,
  active,
  inactive,
  rejected,
}

/// Product certification type
enum CertType {
  vietGAP,
  organic,
  globalGAP,
  other,
}

/// Order processing status
enum OrderStatus {
  pending,
  confirmed,
  preparing,
  shipping,
  delivered,
  completed,
  cancelled,
  refunded,
}

/// Payment method options
enum PaymentMethod {
  cod,
  momo,
  zaloPay,
  vnPay,
  bankTransfer,
  qrCode,
}

/// Payment transaction status
enum PaymentStatus {
  pending,
  processing,
  completed,
  failed,
  refunded,
}

/// Shipment delivery status
enum ShipmentStatus {
  pending,
  accepted,
  pickedUp,
  inTransit,
  delivered,
  failed,
  returned,
}

/// Real-time tracking status
enum TrackingStatus {
  pickedUp,
  inTransit,
  nearDestination,
  delivered,
}

/// Voucher discount type
enum VoucherType {
  percentage,
  fixed,
  freeShipping,
}

/// Notification category
enum NotificationType {
  order,
  promotion,
  message,
  system,
  priceAlert,
}

/// Complaint reason type
enum ComplaintType {
  wrongProduct,
  damaged,
  lateDelivery,
  missingItems,
  other,
}

/// Complaint resolution status
enum ComplaintStatus {
  pending,
  investigating,
  resolved,
  rejected,
}

/// Refund payment method
enum RefundMethod {
  wallet,
  bank,
  originalPayment,
}

/// Refund processing status
enum RefundStatus {
  pending,
  processing,
  completed,
  failed,
}

/// Pre-order status
enum PreOrderStatus {
  pending,
  confirmed,
  ready,
  completed,
  cancelled,
}

/// Livestream session status
enum LivestreamStatus {
  scheduled,
  live,
  ended,
  cancelled,
}