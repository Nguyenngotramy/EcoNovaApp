import 'package:flutter/material.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({Key? key}) : super(key: key);

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  String _selectedUserType = 'Tất cả';
  
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
          'Quản lý người dùng',
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
          _UserFilterWidget(
            selectedType: _selectedUserType,
            onTypeChanged: (type) {
              setState(() {
                _selectedUserType = type;
              });
            },
          ),
          Expanded(
            child: _UserListWidget(userType: _selectedUserType),
          ),
        ],
      ),
    );
  }
}

class _UserFilterWidget extends StatelessWidget {
  final String selectedType;
  final Function(String) onTypeChanged;

  const _UserFilterWidget({
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterChip('Tất cả'),
            const SizedBox(width: 8),
            _buildFilterChip('Người mua'),
            const SizedBox(width: 8),
            _buildFilterChip('Nhà phân phối'),
            const SizedBox(width: 8),
            _buildFilterChip('Vận chuyển'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = selectedType == label;
    return InkWell(
      onTap: () => onTypeChanged(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF043915) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF043915) : const Color(0xFFE0E0E0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Be Vietnam Pro',
            fontSize: 12,
            color: isSelected ? Colors.white : const Color(0xFF666666),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _UserListWidget extends StatelessWidget {
  final String userType;

  const _UserListWidget({required this.userType});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return _UserCardWidget(
          name: 'Nguyễn Văn ${String.fromCharCode(65 + index)}',
          email: 'user${index + 1}@example.com',
          type: index % 3 == 0 ? 'Người mua' : index % 3 == 1 ? 'Nhà phân phối' : 'Vận chuyển',
          avatar: 'U${index + 1}',
          onEdit: () => print('Edit user $index'),
          onDelete: () => print('Delete user $index'),
          onBlock: () => print('Block user $index'),
        );
      },
    );
  }
}

class _UserCardWidget extends StatelessWidget {
  final String name;
  final String email;
  final String type;
  final String avatar;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onBlock;

  const _UserCardWidget({
    required this.name,
    required this.email,
    required this.type,
    required this.avatar,
    required this.onEdit,
    required this.onDelete,
    required this.onBlock,
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
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: const Color(0xFF043915).withOpacity(0.1),
            child: Text(
              avatar,
              style: const TextStyle(
                fontFamily: 'Be Vietnam Pro',
                color: Color(0xFF043915),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontFamily: 'Be Vietnam Pro',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF043915),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: const TextStyle(
                    fontFamily: 'Be Vietnam Pro',
                    fontSize: 12,
                    color: Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF043915).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    type,
                    style: const TextStyle(
                      fontFamily: 'Be Vietnam Pro',
                      fontSize: 10,
                      color: Color(0xFF043915),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF043915)),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'edit', child: Text('Chỉnh sửa')),
              const PopupMenuItem(value: 'delete', child: Text('Xóa')),
              const PopupMenuItem(value: 'block', child: Text('Khóa tài khoản')),
            ],
            onSelected: (value) {
              if (value == 'edit') onEdit();
              if (value == 'delete') onDelete();
              if (value == 'block') onBlock();
            },
          ),
        ],
      ),
    );
  }
}