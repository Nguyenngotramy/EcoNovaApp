import 'package:flutter/material.dart';

class ReportExportSheet extends StatelessWidget {
  const ReportExportSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 180,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.email_outlined),
            title: const Text("Gửi qua Gmail"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.picture_as_pdf),
            title: const Text("Xuất dưới dạng PDF"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
