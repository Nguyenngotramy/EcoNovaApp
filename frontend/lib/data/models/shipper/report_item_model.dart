class ReportItem {
  final String orderId;
  final String customerName;     // địa chỉ gửi
  final String receiverName;     // địa chỉ nhận
  final String sendTime;         // thời gian gửi
  final String receiveTime;      // thời gian nhận
  final String status;           // tình trạng đơn
  final String fee;              // phí giao hàng

  ReportItem({
    required this.orderId,
    required this.customerName,
    required this.receiverName,
    required this.sendTime,
    required this.receiveTime,
    required this.status,
    required this.fee,
  });
}
