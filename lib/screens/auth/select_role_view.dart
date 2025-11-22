import 'package:flutter/material.dart';

class SelectRoleView extends StatefulWidget {
  const SelectRoleView({super.key});

  @override
  State<SelectRoleView> createState() => _SelectRoleViewState();
}

class _SelectRoleViewState extends State<SelectRoleView> {
  String? selectedRole;

  final roles = [
    {"name": "Shipper", "icon": Icons.local_shipping},
    {"name": "Seller", "icon": Icons.store},
    {"name": "Buyer", "icon": Icons.shopping_bag},
    {"name": "Other", "icon": Icons.person},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4CAF50), Color(0xFF45A049)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  // Title
                  const Padding(
                    padding: EdgeInsets.fromLTRB(24, 8, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create your\naccount',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Tell us who you are to enjoy the best experience',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // White content
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Role list
                    ...roles.map((role) {
                      final name = role["name"] as String;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: GestureDetector(
                          onTap: () => setState(() => selectedRole = name),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                              border: Border.all(
                                color: selectedRole == name
                                    ? const Color(0xFF4CAF50)
                                    : Colors.grey.shade300,
                                width: selectedRole == name ? 2 : 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: selectedRole == name
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: selectedRole == name
                                      ? const Color(0xFF4CAF50)
                                      : Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),

                    const Spacer(),

                    // Continue button (PUSH SIGNUP)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: selectedRole == null
                            ? null
                            : () {
                          Navigator.pushNamed(
                            context,
                            "/signup",
                            arguments: selectedRole,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E7D32),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
