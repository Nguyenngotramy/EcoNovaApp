import 'package:eco_nova_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class OTPVerificationView extends StatefulWidget {
  final String phoneNumber;
  final String role;
  final String userId;  // Thêm userId từ register

  const OTPVerificationView({
    super.key,
    required this.phoneNumber,
    required this.role,
    required this.userId,  // Required
  });

  @override
  State<OTPVerificationView> createState() => _OTPVerificationViewState();
}

class _OTPVerificationViewState extends State<OTPVerificationView> {
  final List<TextEditingController> otpControllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  int remainingSeconds = 60;  // Tăng lên 60s
  Timer? timer;
  bool isVerifying = false;  // Loading verify

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    setState(() => remainingSeconds = 60);

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() => remainingSeconds--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header xanh lá (giữ nguyên)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF4CAF50), Color(0xFF45A049)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Verification',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Enter the code sent to ${widget.phoneNumber}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content trắng
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      SizedBox(height: 20),

                      // Message (giữ nguyên)
                      Text(
                        'We\'ve sent an SMS with an activation code to your phone ${widget.phoneNumber}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                          height: 1.4,
                        ),
                      ),

                      SizedBox(height: 40),

                      // OTP input boxes (giữ nguyên)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(6, (index) {
                          return Container(
                            width: 50,
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: otpControllers[index].text.isNotEmpty
                                    ? Color(0xFF4CAF50)
                                    : Colors.grey.shade300,
                                width: 2,
                              ),
                            ),
                            child: TextField(
                              controller: otpControllers[index],
                              focusNode: focusNodes[index],
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty && index < 5) {
                                  focusNodes[index + 1].requestFocus();
                                } else if (value.isEmpty && index > 0) {
                                  focusNodes[index - 1].requestFocus();
                                }

                                // Auto verify when all filled
                                if (index == 5 && value.isNotEmpty) {
                                  _verifyOTP();
                                }
                                setState(() {});
                              },
                            ),
                          );
                        }),
                      ),

                      SizedBox(height: 30),

                      // Resend code (giữ nguyên)
                      TextButton(
                        onPressed: remainingSeconds == 0 ? () => startTimer() : null,
                        child: Text(
                          remainingSeconds > 0
                              ? 'Send code again  00:${remainingSeconds.toString().padLeft(2, '0')}'
                              : 'Send code again',
                          style: TextStyle(
                            fontSize: 14,
                            color: remainingSeconds > 0
                                ? Colors.grey.shade600
                                : Color(0xFF4CAF50),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _verifyOTP() async {
    String otp = otpControllers.map((c) => c.text).join();
    if (otp.length != 6) return;

    setState(() => isVerifying = true);  // Loading
    try {
      await AuthService.verifyOtp(widget.userId, otp);  // Gọi API
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Xác thực thành công!'),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );

      // Navigate dựa role (token đã lưu)
      if (widget.role == "Buyer") {
        Navigator.pushReplacementNamed(context, "/buyerHome");
      } else if (widget.role == "Seller") {
        Navigator.pushReplacementNamed(context, "/sellerHome");
      } else if (widget.role == "Shipper") {
        Navigator.pushReplacementNamed(context, "/shipperHome");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() => isVerifying = false);
  }

  @override
  void dispose() {
    timer?.cancel();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }
}