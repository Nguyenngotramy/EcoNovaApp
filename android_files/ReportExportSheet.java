import 'package:flutter/material.dart';

class ReportExportSheet extends StatelessWidget {
  const ReportExportSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Gmail option
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.email_outlined,
                  color: Colors.grey.shade700,
                  size: 24,
                ),
              ),
              title: const Text(
                "Gửi qua Gmail",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // Handle Gmail export
                _exportViaGmail(context);
              },
            ),
            
            // Divider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Divider(
                height: 1,
                color: Colors.grey.shade200,
              ),
            ),
            
            // PDF option
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.picture_as_pdf_outlined,
                  color: Colors.grey.shade700,
                  size: 24,
                ),
              ),
              title: const Text(
                "Xuất dưới dạng PDF",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // Handle PDF export
                _exportAsPDF(context);
              },
            ),
            
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _exportViaGmail(BuildContext context) {
    // Implement Gmail export logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đang chuẩn bị gửi qua Gmail...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _exportAsPDF(BuildContext context) {
    // Implement PDF export logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đang xuất file PDF...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Static method to show the bottom sheet
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const ReportExportSheet(),
    );
  }
}

// Example usage in your reports statistics screen:
/*
// Add this to your ReportsStatisticScreen or wherever you need to show the export options

ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF1B5E20),
    minimumSize: const Size(double.infinity, 48),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  onPressed: () {
    ReportExportSheet.show(context);
  },
  child: const Text(
    "XUẤT FILE BÁO CÁO",
    style: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
)
*/