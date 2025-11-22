class DeliveryOrder {
  final String orderId;

  final String senderName;
  final String senderPhone;
  final String senderAddress;

  final String receiverName;
  final String receiverPhone;
  final String receiverAddress;

  /// "pending" | "delivering" | "done"
  final String statusCode;
  final String statusText;
  final String fee;

  final String sendTime;
  final String receiveTime;

  DeliveryOrder({
    required this.orderId,
    required this.senderName,
    required this.senderPhone,
    required this.senderAddress,
    required this.receiverName,
    required this.receiverPhone,
    required this.receiverAddress,
    required this.statusCode,
    required this.statusText,
    required this.fee,
    required this.sendTime,
    required this.receiveTime,
  });
}
