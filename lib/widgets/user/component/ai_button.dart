import 'package:eco_nova_app/widgets/user/chat/aichat.dart';
import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
// Assuming AIChatScreen is imported from the appropriate location
// import 'path/to/ai_chat_screen.dart'; // Uncomment and adjust path as needed

class AI_Button extends StatelessWidget {
  const AI_Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AIChatScreen(),
          ),
        );
      },
      backgroundColor: AppTheme.primary,
      child: const Icon(Icons.smart_toy, color: Colors.white),
    );
  }
}