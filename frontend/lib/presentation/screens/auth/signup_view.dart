import 'package:eco_nova_app/presentation/screens/auth/otp_verify_view.dart';
import 'package:eco_nova_app/services/auth_service.dart';
import 'package:flutter/material.dart';

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
  bool isLoading = false;  // Thêm loading

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

            // Content trắng (giữ nguyên, chỉ thêm loading ở button)
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
                      // Tabs (giữ nguyên)
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

                      // Form fields (giữ nguyên)
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

                      // Terms checkbox (giữ nguyên)
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

                      // Register button (cập nhật với loading & API)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: acceptTerms && !isLoading ? _handleRegister : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF2E7D32),
                            disabledBackgroundColor: Colors.grey.shade300,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 0,
                          ),
                          child: isLoading
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
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

  Future<void> _handleRegister() async {
    if (fullNameCtrl.text.isEmpty || emailCtrl.text.isEmpty || passCtrl.text.isEmpty || phoneCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Vui lòng điền đầy đủ')));
      return;
    }

    setState(() => isLoading = true);
    try {
      // Gọi API register
      final data = await AuthService.register(
        fullNameCtrl.text.trim(),  // Username
        emailCtrl.text.trim(),
        phoneCtrl.text.trim(),
        passCtrl.text,
        licenseCtrl.text.trim(),
        widget.role,
      );

      // Navigate OTP với userId
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPVerificationView(
            phoneNumber: phoneCtrl.text.trim(),
            role: widget.role,
            userId: data['userId'],  // Truyền userId
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() => isLoading = false);
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