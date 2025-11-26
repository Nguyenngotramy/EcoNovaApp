import 'package:flutter/material.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String newPhone;

  const VerifyOtpScreen({super.key, required this.newPhone});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  // Constants
  static const int _otpLength = 6;
  static const double _horizontalPadding = 16.0;
  static const double _buttonVerticalPadding = 14.0;
  static const double _borderRadius = 12.0;

  // Controllers
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _verifyOtp() async {
    final otp = _otpController.text.trim();

    if (otp.length != _otpLength) {
      _showErrorSnackBar('Vui lòng nhập đầy đủ (_otpLength) số OTP');
      return;
    }

    // TODO: Gọi API xác thực OTP ở đây
    // Giả sử xác thực thành công
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 12),
            Text('Cập nhật thành công'),
          ],
        ),
        content: Text(
          'Số điện thoại của bạn đã được cập nhật thành ${widget.newPhone}',
          style: const TextStyle(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context)
                ..pop() // Đóng dialog
                ..pop() // Thoát màn hình OTP
                ..pop(); // Thoát màn hình thay đổi số điện thoại
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.green.shade800,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              'ĐỒNG Ý',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(_horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInstructions(),
              const SizedBox(height: 24),
              _buildOtpField(),
              const SizedBox(height: 16),
              _buildResendOtpButton(),
              const Spacer(),
              _buildConfirmButton(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black87),
        onPressed: () => Navigator.of(context).pop(),
      ),
      centerTitle: true,
      title: const Text(
        'Xác nhận OTP',
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildInstructions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(_borderRadius),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: Colors.blue.shade700, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Vui lòng nhập mã OTP $_otpLength số được gửi đến ${widget.newPhone}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue.shade900,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpField() {
    return TextField(
      controller: _otpController,
      keyboardType: TextInputType.number,
      maxLength: _otpLength,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 8,
      ),
      decoration: InputDecoration(
        counterText: '',
        hintText: '• • • • • •',
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          letterSpacing: 12,
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(color: Colors.green.shade800, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
      ),
    );
  }

  Widget _buildResendOtpButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        onPressed: () {
          // TODO: Implement resend OTP
          _showErrorSnackBar('Đã gửi lại mã OTP');
        },
        icon: const Icon(Icons.refresh, size: 18),
        label: const Text(
          'Gửi lại mã',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        style: TextButton.styleFrom(
          foregroundColor: Colors.green.shade800,
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return ElevatedButton(
      onPressed: _verifyOtp,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green.shade800,
        foregroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.green.shade800.withOpacity(0.4),
        padding: const EdgeInsets.symmetric(vertical: _buttonVerticalPadding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
      ),
      child: const Text(
        'XÁC NHẬN',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}