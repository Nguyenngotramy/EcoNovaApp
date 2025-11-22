import 'package:flutter/material.dart';

class BannerPromotionScreen extends StatelessWidget {
  const BannerPromotionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF043915)),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Banner & Khuyến mãi',
            style: TextStyle(
              fontFamily: 'Be Vietnam Pro',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF043915),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add, color: Color(0xFF043915)),
              onPressed: () {},
            ),
          ],
          bottom: const TabBar(
            labelColor: Color(0xFF043915),
            unselectedLabelColor: Color(0xFF999999),
            indicatorColor: Color(0xFF043915),
            labelStyle: TextStyle(
              fontFamily: 'Be Vietnam Pro',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            tabs: [
              Tab(text: 'Banner'),
              Tab(text: 'Flash Sale'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _BannerListWidget(),
            _FlashSaleListWidget(),
          ],
        ),
      ),
    );
  }
}

class _BannerListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _BannerCardWidget(
          title: 'Banner ${index + 1}',
          description: 'Khuyến mãi đặc biệt cuối năm',
          status: index % 2 == 0 ? 'Đang hoạt động' : 'Tạm dừng',
          startDate: '01/11/2024',
          endDate: '30/11/2024',
        );
      },
    );
  }
}

class _BannerCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final String status;
  final String startDate;
  final String endDate;

  const _BannerCardWidget({
    required this.title,
    required this.description,
    required this.status,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.image,
                size: 50,
                color: const Color(0xFFE0E0E0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'Be Vietnam Pro',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF043915),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: status == 'Đang hoạt động' 
                            ? const Color(0xFF043915).withOpacity(0.1)
                            : const Color(0xFF999999).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontFamily: 'Be Vietnam Pro',
                          fontSize: 10,
                          color: status == 'Đang hoạt động' ? const Color(0xFF043915) : const Color(0xFF999999),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    fontFamily: 'Be Vietnam Pro',
                    fontSize: 12,
                    color: Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 12, color: const Color(0xFF666666)),
                    const SizedBox(width: 4),
                    Text(
                      '$startDate - $endDate',
                      style: const TextStyle(
                        fontFamily: 'Be Vietnam Pro',
                        fontSize: 11,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF043915),
                          side: const BorderSide(color: Color(0xFF043915)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Chỉnh sửa',
                          style: TextStyle(
                            fontFamily: 'Be Vietnam Pro',
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF043915),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          status == 'Đang hoạt động' ? 'Tạm dừng' : 'Kích hoạt',
                          style: const TextStyle(
                            fontFamily: 'Be Vietnam Pro',
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FlashSaleListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 4,
      itemBuilder: (context, index) {
        return _FlashSaleCardWidget(
          title: 'Flash Sale ${index + 1}',
          discount: '${20 + (index * 10)}%',
          products: 15 + (index * 3),
          startTime: '${10 + (index * 3)}:00',
          endTime: '${12 + (index * 3)}:00',
          status: index == 0 ? 'Đang diễn ra' : 'Sắp diễn ra',
        );
      },
    );
  }
}

class _FlashSaleCardWidget extends StatelessWidget {
  final String title;
  final String discount;
  final int products;
  final String startTime;
  final String endTime;
  final String status;

  const _FlashSaleCardWidget({
    required this.title,
    required this.discount,
    required this.products,
    required this.startTime,
    required this.endTime,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Be Vietnam Pro',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF043915),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9800),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  discount,
                  style: const TextStyle(
                    fontFamily: 'Be Vietnam Pro',
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.inventory_2_outlined, size: 16, color: const Color(0xFF666666)),
              const SizedBox(width: 4),
              Text(
                '$products sản phẩm',
                style: const TextStyle(
                  fontFamily: 'Be Vietnam Pro',
                  fontSize: 12,
                  color: Color(0xFF666666),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: const Color(0xFF666666)),
              const SizedBox(width: 4),
              Text(
                '$startTime - $endTime',
                style: const TextStyle(
                  fontFamily: 'Be Vietnam Pro',
                  fontSize: 12,
                  color: Color(0xFF666666),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: status == 'Đang diễn ra' 
                  ? const Color(0xFF043915).withOpacity(0.1)
                  : const Color(0xFF2196F3).withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontFamily: 'Be Vietnam Pro',
                fontSize: 10,
                color: status == 'Đang diễn ra' ? const Color(0xFF043915) : const Color(0xFF2196F3),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}