import 'package:eco_nova_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eco_nova_app/providers/user_provider.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool isLoading = false;
  bool showPassword = false;
  bool rememberMe = false;
  bool isLoginTab = true; // true = Login, false = Register
  String? errorMessage; // Lưu message lỗi

  Future<void> signIn() async {
    setState(() {
      isLoading = true;
      errorMessage = null; // reset lỗi cũ
    });
    try {
      final data =
          await AuthService.login(emailCtrl.text.trim(), passCtrl.text);
      // Kiểm tra message từ backend
      if (data['message'] != 'Login successful') {
        setState(() {
          errorMessage = data['message'] ?? 'Login failed';
        });
      } else {
        Provider.of<UserProvider>(context, listen: false).setUser(data['user']);
        final user = Provider.of<UserProvider>(context, listen: false).user;
        print(user);
        switch (data['user']['role']) {
          case 'buyer':
            Navigator.pushReplacementNamed(context, '/user');
            break;
          case 'seller':
            Navigator.pushReplacementNamed(context, '/seller');
            break;
          case 'shipper':
            Navigator.pushReplacementNamed(context, '/shipper');
            break;
          case 'admin':
            Navigator.pushReplacementNamed(context, '/admin');
            break;
          default:
            Navigator.pushReplacementNamed(context, '/role');
            break;
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() => isLoading = false);
  }

  Future<void> signInWithGoogle() async {
    setState(() => isLoading = true);
    // Stub Google (thêm package google_sign_in nếu cần full)
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/role');
    }
    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // Header với gradient xanh lá
              Container(
                height: 280,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF66BB6A),
                      Color(0xFF2E7D32),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back button
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Title
                        const Text(
                          "Go ahead and set up\nyour account",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Sign in-up to enjoy the best managing experience",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // White card container
              Positioned(
                top: 250,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // Login / Register tabs
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () =>
                                      setState(() => isLoginTab = true),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isLoginTab
                                          ? Colors.white
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: isLoginTab
                                          ? [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                blurRadius: 8,
                                                offset: const Offset(0, 2),
                                              ),
                                            ]
                                          : null,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: isLoginTab
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: isLoginTab
                                              ? const Color(0xFF2E7D32)
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() => isLoginTab = false);
                                    Navigator.pushNamed(context, "/selectRole");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: !isLoginTab
                                          ? Colors.white
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Register",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: !isLoginTab
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: !isLoginTab
                                              ? const Color(0xFF2E7D32)
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Email field
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          child: TextField(
                            controller: emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: Color(0xFF757575),
                                size: 22,
                              ),
                              hintText: "E-mail ID",
                              hintStyle: const TextStyle(
                                color: Color(0xFF9E9E9E),
                                fontSize: 15,
                              ),
                              filled: false,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Password field
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          child: TextField(
                            controller: passCtrl,
                            obscureText: !showPassword,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                color: Color(0xFF757575),
                                size: 22,
                              ),
                              hintText: "Password",
                              hintStyle: const TextStyle(
                                color: Color(0xFF9E9E9E),
                                fontSize: 15,
                              ),
                              filled: false,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  showPassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: const Color(0xFF757575),
                                  size: 22,
                                ),
                                onPressed: () {
                                  setState(() => showPassword = !showPassword);
                                },
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Remember me & Forgot password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Checkbox(
                                    value: rememberMe,
                                    onChanged: (value) {
                                      setState(
                                          () => rememberMe = value ?? false);
                                    },
                                    activeColor: const Color(0xFF2E7D32),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "Remember me",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF757575),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                // TODO: Navigate to forgot password
                              },
                              child: const Text(
                                "Forget Password?",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF2E7D32),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // Login button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : signIn,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1B5E20),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                              disabledBackgroundColor:
                                  const Color(0xFF1B5E20).withOpacity(0.6),
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : const Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                        if (errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              errorMessage!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                        const SizedBox(height: 24),

                        // Or login with
                        const Text(
                          "Or login with",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF9E9E9E),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Social login buttons
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: isLoading ? null : signInWithGoogle,
                                icon: Image.asset(
                                  'assets/images/google_icon.png',
                                  width: 20,
                                  height: 20,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.g_mobiledata,
                                      color: Colors.red,
                                      size: 24,
                                    );
                                  },
                                ),
                                label: const Text(
                                  "Google",
                                  style: TextStyle(
                                    color: Color(0xFF424242),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  side: BorderSide(
                                    color: Colors.grey.shade300,
                                    width: 1.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  // TODO: Implement Apple sign in
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Apple sign in not implemented yet"),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.apple,
                                  color: Color(0xFF424242),
                                  size: 24,
                                ),
                                label: const Text(
                                  "Apple",
                                  style: TextStyle(
                                    color: Color(0xFF424242),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  side: BorderSide(
                                    color: Colors.grey.shade300,
                                    width: 1.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
