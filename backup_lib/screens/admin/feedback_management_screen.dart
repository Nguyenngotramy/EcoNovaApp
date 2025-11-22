import 'package:flutter/material.dart';

class FeedbackManagementScreen extends StatefulWidget {
  const FeedbackManagementScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackManagementScreen> createState() => _FeedbackManagementScreenState();
}

class _FeedbackManagementScreenState extends State<FeedbackManagementScreen> {
  String _selectedPriority = 'Tất cả';

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
          'Phản hồi & Khiếu nại',
          style: TextStyle(
            fontFamily: 'Be Vietnam Pro',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF043915),
          ),
        ),
      ),
      body: Column(
        children: [
          _FeedbackFilterWidget(
            selectedPriority: _selectedPriority,
            onPriorityChanged: (priority) {
              setState(() {
                _selectedPriority = priority;
              });
            },
          ),
          Expanded(
            child: _FeedbackListWidget(priority: _selectedPriority),
          ),
        ],
      ),
    );
  }
}

class _FeedbackFilterWidget extends StatelessWidget {
  final String selectedPriority;
  final Function(String) onPriorityChanged;

  const _FeedbackFilterWidget({
    required this.selectedPriority,
    required this.onPriorityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildChip('Tất cả'),
          const SizedBox(width: 8),
          _buildChip('Khẩn cấp'),
          const SizedBox(width: 8),
          _buildChip('Cao'),
          const SizedBox(width: 8),
          _buildChip('Trung bình'),
          const SizedBox(width: 8),
          _buildChip('Thấp'),
        ],
      ),
    );
  }

  Widget _buildChip(String label) {
    final isSelected = selectedPriority == label;
    return Expanded(
      child: InkWell(
        onTap: () => onPriorityChanged(label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF043915) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? const Color(0xFF043915) : const Color(0xFFE0E0E0),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Be Vietnam Pro',
              fontSize: 10,
              color: isSelected ? Colors.white : const Color(0xFF666666),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class _FeedbackListWidget extends StatelessWidget {
  final String priority;

  const _FeedbackListWidget({required this.priority});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 8,
      itemBuilder: (context, index) {
        return _FeedbackCardWidget(
          id: '#FB${1000 + index}',
          customerName: 'Khách hàng ${String.fromCharCode(65 + index)}',
          subject: index % 2 == 0 ? 'Sản phẩm lỗi' : 'Giao hàng chậm',
          message: 'Tôi đã đặt hàng từ 3 ngày trước nhưng vẫn chưa nhận được...',
          priority: index % 4 == 0 ? 'Khẩn cấp' : index % 4 == 1 ? 'Cao' : index % 4 == 2 ? 'Trung bình' : 'Thấp',
          time: '${index + 1}h trước',
          status: index % 3 == 0 ? 'Chờ xử lý' : 'Đã xử lý',
        );
      },
    );
  }
}

class _FeedbackCardWidget extends StatelessWidget {
  final String id;
  final String customerName;
  final String subject;
  final String message;
  final String priority;
  final String time;
  final String status;

  const _FeedbackCardWidget({
    required this.id,
    required this.customerName,
    required this.subject,
    required this.message,
    required this.priority,
    required this.time,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color priorityColor = priority == 'Khẩn cấp' 
        ? const Color(0xFFE53935)
        : priority == 'Cao' 
            ? const Color(0xFFFF9800)
            : priority == 'Trung bình'
                ? const Color(0xFF2196F3)
                : const Color(0xFF666666);

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
                id,
                style: const TextStyle(
                  fontFamily: 'Be Vietnam Pro',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF043915),
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: priorityColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      priority,
                      style: TextStyle(
                        fontFamily: 'Be Vietnam Pro',
                        fontSize: 10,
                        color: priorityColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: status == 'Chờ xử lý' 
                          ? const Color(0xFFFF9800).withOpacity(0.1)
                          : const Color(0xFF043915).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontFamily: 'Be Vietnam Pro',
                        fontSize: 10,
                        color: status == 'Chờ xử lý' ? const Color(0xFFFF9800) : const Color(0xFF043915),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            customerName,
            style: const TextStyle(
              fontFamily: 'Be Vietnam Pro',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF043915),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subject,
            style: const TextStyle(
              fontFamily: 'Be Vietnam Pro',
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF043915),
            ),
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
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontFamily: 'Be Vietnam Pro',
                  fontSize: 11,
                  color: Color(0xFF999999),
                ),
              ),
              if (status == 'Chờ xử lý')
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Xử lý ngay',
                    style: TextStyle(
                      fontFamily: 'Be Vietnam Pro',
                      fontSize: 12,
                      color: Color(0xFF043915),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}