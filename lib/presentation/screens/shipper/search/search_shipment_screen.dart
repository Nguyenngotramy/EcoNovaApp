import 'package:flutter/material.dart';

class SearchShipmentScreen extends StatefulWidget {
  const SearchShipmentScreen({super.key});

  @override
  State<SearchShipmentScreen> createState() => _SearchShipmentScreenState();
}

class _SearchShipmentScreenState extends State<SearchShipmentScreen> {
  final TextEditingController _controller = TextEditingController();

  List<String> mockResults = []; // Replace bằng API thật sau này

  void _search(String keyword) {
    // Fake lọc tạm thời
    setState(() {
      mockResults = [
        "ST779890R12 - 09652371569",
        "ST445533A21 - 0988123456",
        "ST112233B99 - 0905667788"
      ].where((item) => item.toLowerCase().contains(keyword.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Tìm kiếm đơn hàng",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onChanged: _search,
              decoration: InputDecoration(
                hintText: "Nhập mã vận đơn hoặc số điện thoại...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: mockResults.isEmpty
                  ? const Center(child: Text("Không có kết quả"))
                  : ListView.builder(
                itemCount: mockResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.local_shipping),
                    title: Text(mockResults[index]),
                    onTap: () {
                      // mở chi tiết đơn (tuỳ bạn)
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
