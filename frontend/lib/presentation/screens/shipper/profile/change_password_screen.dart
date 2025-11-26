import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final passController = TextEditingController();
  final confirmController = TextEditingController();

  bool showPass = false;
  bool showConfirm = false;

  void _updateSuccess() {
    showDialog(
      context: context,
      builder: (_) => _buildCustomDialog(context),
    );
  }

  Widget _buildCustomDialog(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.check_circle_outline,
                color: Color(0xFF1B5E20),
                size: 32,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Đã cập nhật mật khẩu",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Mật khẩu của bạn đã được cập nhật thành công.\nTài khoản của bạn hiện đã an toàn hơn.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
                letterSpacing: -0.2,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B5E20),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Đóng",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 24),
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
        ),
        title: const Text(
          "Thay đổi mật khẩu",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        centerTitle: false,
        titleSpacing: 8,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              physics: const BouncingScrollPhysics(),
              children: [
                // DESCRIPTION
                Text(
                  "Bạn có thể thay đổi mật khẩu tại đây để giữ an toàn cho tài khoản.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                    letterSpacing: -0.2,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 28),

                // PASSWORD STRENGTH INDICATOR
                _buildPasswordStrengthIndicator(),

                const SizedBox(height: 24),

                // NEW PASSWORD INPUT
                _buildPasswordField(
                  label: "Mật khẩu mới",
                  controller: passController,
                  obscure: !showPass,
                  toggle: () => setState(() => showPass = !showPass),
                  showToggle: true,
                ),

                const SizedBox(height: 18),

                // CONFIRM PASSWORD INPUT
                _buildPasswordField(
                  label: "Xác nhận mật khẩu mới",
                  controller: confirmController,
                  obscure: !showConfirm,
                  toggle: () => setState(() => showConfirm = !showConfirm),
                  showToggle: true,
                ),

                const SizedBox(height: 24),

                // SECURITY TIPS
                _buildSecurityTips(),
              ],
            ),
          ),

          // BUTTON AT BOTTOM
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: _buildSaveButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordStrengthIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFBBDEFB),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.info_outline,
            color: Color(0xFF1565C0),
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Mật khẩu mạnh gồm ít nhất 8 ký tự, chứa chữ hoa, chữ thường, số và ký tự đặc biệt",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
                letterSpacing: -0.2,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback toggle,
    required bool showToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscure,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
            letterSpacing: -0.2,
          ),
          decoration: InputDecoration(
            prefixIcon: Container(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.lock_outline,
                size: 20,
                color: const Color(0xFF1B5E20),
              ),
            ),
            suffixIcon: showToggle
                ? IconButton(
              icon: Icon(
                obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                size: 20,
                color: Colors.grey.shade600,
              ),
              onPressed: toggle,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
            )
                : null,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey.shade200,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey.shade200,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF1B5E20),
                width: 2,
              ),
            ),
            hintText: "Nhập mật khẩu",
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade400,
              letterSpacing: -0.2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityTips() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFFFE0B2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.security_outlined,
                color: Color(0xFFE65100),
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                "Mẹo bảo mật",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade800,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "• Không chia sẻ mật khẩu với bất kỳ ai\n• Không sử dụng mật khẩu trong các tài khoản khác\n• Thay đổi mật khẩu thường xuyên",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
              letterSpacing: -0.2,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1B5E20),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        onPressed: _updateSuccess,
        child: const Text(
          "LƯU THAY ĐỔI",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    passController.dispose();
    confirmController.dispose();
    super.dispose();
  }
}