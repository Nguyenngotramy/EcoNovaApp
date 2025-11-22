import 'package:flutter/material.dart';

class NotificationManagementScreen extends StatelessWidget {
  const NotificationManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF043915)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Quản lý thông báo',
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
      ),
      body: Column(
        children: [
          _NotificationStatsWidget(),
          const SizedBox(height: 16),
          Expanded(
            child: _NotificationListWidget(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: const Color(0xFF043915),
        icon: const Icon(Icons.send, color: Colors.white),
        label: const Text(
          'Gửi thông báo',
          style: TextStyle(
            fontFamily: 'Be Vietnam Pro',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _NotificationStatsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF043915).withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF043915).withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Đã gửi', '234', Icons.send),
          Container(width: 1, height: 40, color: const Color(0xFFE0E0E0)),
          _buildStatItem('Đã đọc', '189', Icons.mark_email_read),
          Container(width: 1, height: 40, color: const Color(0xFFE0E0E0)),
          _buildStatItem('Chờ gửi', '12', Icons.schedule),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF043915), size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Be Vietnam Pro',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF043915),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Be Vietnam Pro',
            fontSize: 12,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }
}

class _NotificationListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return _NotificationCardWidget(
          title: index % 3 == 0 
              ? 'Bảo trì hệ thống' 
              : index % 3 == 1 
                  ? 'Cập nhật tính năng mới'
                  : 'Thông báo khuyến mãi',
          message: 'Hệ thống sẽ bảo trì từ 2h-4h sáng ngày mai. Vui lòng hoàn thành các giao dịch trước thời gian này.',
          recipients: index % 2 == 0 ? 'Tất cả người dùng' : 'Nhà phân phối',
          time: '${index + 1}h trước',
          status: index % 3 == 0 ? 'Đã gửi' : index % 3 == 1 ? 'Chờ gửi' : 'Nháp',
          readCount: index % 3 == 0 ? 156 : 0,
          totalCount: 234,
        );
      },
    );
  }
}

class _NotificationCardWidget extends StatelessWidget {
  final String title;
  final String message;
  final String recipients;
  final String time;
  final String status;
  final int readCount;
  final int totalCount;

  const _NotificationCardWidget({
    required this.title,
    required this.message,
    required this.recipients,
    required this.time,
    required this.status,
    required this.readCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor = status == 'Đã gửi' 
        ? const Color(0xFF043915)
        : status == 'Chờ gửi' 
            ? const Color(0xFFFF9800)
            : const Color(0xFF999999);

    IconData statusIcon = status == 'Đã gửi' 
        ? Icons.check_circle
        : status == 'Chờ gửi' 
            ? Icons.schedule
            : Icons.edit;

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
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Be Vietnam Pro',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF043915),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Icon(statusIcon, size: 12, color: statusColor),
                    const SizedBox(width: 4),
                    Text(
                      status,
                      style: TextStyle(
                        fontFamily: 'Be Vietnam Pro',
                        fontSize: 10,
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            message,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Be Vietnam Pro',
              fontSize: 12,
              color: Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.people, size: 14, color: const Color(0xFF999999)),
              const SizedBox(width: 4),
              Text(
                recipients,
                style: const TextStyle(
                  fontFamily: 'Be Vietnam Pro',
                  fontSize: 11,
                  color: Color(0xFF999999),
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.access_time, size: 14, color: const Color(0xFF999999)),
              const SizedBox(width: 4),
              Text(
                time,
                style: const TextStyle(
                  fontFamily: 'Be Vietnam Pro',
                  fontSize: 11,
                  color: Color(0xFF999999),
                ),
              ),
            ],
          ),
          if (status == 'Đã gửi') ...[
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: readCount / totalCount,
              backgroundColor: const Color(0xFFE0E0E0),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF043915)),
            ),
            const SizedBox(height: 4),
            Text(
              'Đã đọc: $readCount/$totalCount',
              style: const TextStyle(
                fontFamily: 'Be Vietnam Pro',
                fontSize: 11,
                color: Color(0xFF666666),
              ),
            ),
          ],
          if (status != 'Đã gửi') ...[
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
                      padding: const EdgeInsets.symmetric(vertical: 8),
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
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: const Text(
                      'Gửi ngay',
                      style: TextStyle(
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
        ],
      ),
    );
  }
}