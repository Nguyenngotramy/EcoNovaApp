import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

// ==================== SIGN UP VIEW ====================
class SignUpView extends StatefulWidget {
  final String role;

  const SignUpView({super.key, required this.role});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final fullNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final licenseCtrl = TextEditingController();

  bool acceptTerms = false;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header xanh lá
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
                          'Create your\naccount',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Sign up now to enjoy the best managing experience',
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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Login/Register tabs
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    'Login',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'Register',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24),

                      // Form fields
                      _buildTextField(
                        controller: fullNameCtrl,
                        icon: Icons.person_outline,
                        hint: 'Full Name',
                      ),
                      SizedBox(height: 12),

                      _buildTextField(
                        controller: emailCtrl,
                        icon: Icons.email_outlined,
                        hint: 'Email-ID',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 12),

                      _buildTextField(
                        controller: passCtrl,
                        icon: Icons.lock_outline,
                        hint: 'Password',
                        obscureText: obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() => obscurePassword = !obscurePassword);
                          },
                        ),
                      ),
                      SizedBox(height: 12),

                      _buildTextField(
                        controller: phoneCtrl,
                        icon: Icons.phone_outlined,
                        hint: 'Phone No.',
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 12),

                      _buildTextField(
                        controller: licenseCtrl,
                        icon: Icons.badge_outlined,
                        hint: 'License No.',
                      ),

                      SizedBox(height: 20),

                      // Terms checkbox
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() => acceptTerms = !acceptTerms);
                            },
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: acceptTerms ? Color(0xFF4CAF50) : Colors.transparent,
                                border: Border.all(
                                  color: acceptTerms ? Color(0xFF4CAF50) : Colors.grey.shade400,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: acceptTerms
                                  ? Icon(Icons.check, size: 16, color: Colors.white)
                                  : null,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'I accept the terms and privacy policy',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 24),

                      // Register button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: acceptTerms ? () => _handleRegister() : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF2E7D32),
                            disabledBackgroundColor: Colors.grey.shade300,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          prefixIcon: Icon(icon, color: Colors.grey.shade600),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }

  void _handleRegister() {
    // Validate fields
    if (fullNameCtrl.text.isEmpty ||
        emailCtrl.text.isEmpty ||
        passCtrl.text.isEmpty ||
        phoneCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    // Navigate to OTP screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OTPVerificationView(
          phoneNumber: phoneCtrl.text.trim(),
          role: widget.role,
        ),
      ),
    );
  }

  @override
  void dispose() {
    fullNameCtrl.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
    phoneCtrl.dispose();
    licenseCtrl.dispose();
    super.dispose();
  }
}

// ==================== OTP VERIFICATION VIEW ====================
class OTPVerificationView extends StatefulWidget {
  final String phoneNumber;
  final String role;   // <= THÊM

  const OTPVerificationView({
    super.key,
    required this.phoneNumber,
    required this.role,
  });


  @override
  State<OTPVerificationView> createState() => _OTPVerificationViewState();
}

class _OTPVerificationViewState extends State<OTPVerificationView> {
  final List<TextEditingController> otpControllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes =
  List.generate(6, (_) => FocusNode());

  int remainingSeconds = 20;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    setState(() => remainingSeconds = 20);

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
            // Header xanh lá
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
                          'Create your\naccount',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Sign up now to enjoy the best managing experience',
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

                      // Message
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

                      // OTP input boxes
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

                      // Resend code
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

  void _verifyOTP() {
    String otp = otpControllers.map((c) => c.text).join();

    if (otp.length == 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Account created successfully!'),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );

      if (widget.role == "Buyer") {
        Navigator.pushReplacementNamed(context, "/buyerHome");
      } else if (widget.role == "Seller") {
        Navigator.pushReplacementNamed(context, "/sellerHome");
      } else if (widget.role == "Shipper") {
        Navigator.pushReplacementNamed(context, "/shipperHome");
      }
    }
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