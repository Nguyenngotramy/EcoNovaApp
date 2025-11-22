import 'package:eco_nova_app/widgets/seller/componnet/form_components.dart';
import 'package:flutter/material.dart';
import 'package:eco_nova_app/theme/app_theme.dart';


class SellerProfileScreen extends StatefulWidget {
  const SellerProfileScreen({super.key});

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Shop Info Controllers
  final TextEditingController _shopNameController = TextEditingController(text: 'Fresh Farm');
  final TextEditingController _shopDescriptionController = TextEditingController(
    text: 'Chuyên cung cấp rau củ quả hữu cơ tươi sạch từ nông trại',
  );
  final TextEditingController _shopAddressController = TextEditingController(
    text: '123 Đường Lê Văn Lương, Q.7, TP.HCM',
  );
  final TextEditingController _shopPhoneController = TextEditingController(text: '0901234567');
  final TextEditingController _shopEmailController = TextEditingController(text: 'freshfarm@example.com');
  
  // Owner Info Controllers
  final TextEditingController _ownerNameController = TextEditingController(text: 'Nguyễn Văn A');
  final TextEditingController _ownerPhoneController = TextEditingController(text: '0901234567');
  final TextEditingController _ownerEmailController = TextEditingController(text: 'owner@example.com');
  final TextEditingController _taxCodeController = TextEditingController(text: '0123456789');
  final TextEditingController _businessLicenseController = TextEditingController(text: 'GP-12345');
  
  // Bank Info Controllers
  final TextEditingController _bankNameController = TextEditingController(text: 'Vietcombank');
  final TextEditingController _bankAccountController = TextEditingController(text: '1234567890');
  final TextEditingController _bankOwnerController = TextEditingController(text: 'NGUYEN VAN A');
  
  String? _shopImageUrl = 'https://via.placeholder.com/150';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _shopNameController.dispose();
    _shopDescriptionController.dispose();
    _shopAddressController.dispose();
    _shopPhoneController.dispose();
    _shopEmailController.dispose();
    _ownerNameController.dispose();
    _ownerPhoneController.dispose();
    _ownerEmailController.dispose();
    _taxCodeController.dispose();
    _businessLicenseController.dispose();
    _bankNameController.dispose();
    _bankAccountController.dispose();
    _bankOwnerController.dispose();
    super.dispose();
  }

  void _handleUpdateProfile() async {
    setState(() => _isLoading = true);
    
    // Mock API call
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() => _isLoading = false);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cập nhật thông tin thành công!'),
          backgroundColor: AppTheme.successColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Thông tin cửa hàng', style: AppTheme.heading3),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primary,
          unselectedLabelColor: AppTheme.textLight,
          indicatorColor: AppTheme.primary,
          tabs: const [
            Tab(text: 'Cửa hàng'),
            Tab(text: 'Chủ shop'),
            Tab(text: 'Ngân hàng'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildShopInfoTab(),
          _buildOwnerInfoTab(),
          _buildBankInfoTab(),
        ],
      ),
      bottomNavigationBar: ActionButtonGroup(
        primaryText: 'Lưu thay đổi',
        onPrimary: _handleUpdateProfile,
        isLoading: _isLoading,
      ),
    );
  }

  Widget _buildShopInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shop Avatar
          Center(
            child: Stack(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.borderColor, width: 2),
                  ),
                  child: ClipOval(
                    child: _shopImageUrl != null
                        ? Image.network(
                            _shopImageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: AppTheme.cardBackground,
                                child: const Icon(
                                  Icons.store,
                                  size: 48,
                                  color: AppTheme.textLight,
                                ),
                              );
                            },
                          )
                        : Container(
                            color: AppTheme.cardBackground,
                            child: const Icon(
                              Icons.store,
                              size: 48,
                              color: AppTheme.textLight,
                            ),
                          ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      // Handle change avatar
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Shop Info
          CustomTextField(
            label: 'Tên cửa hàng',
            controller: _shopNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập tên cửa hàng';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          
          CustomTextField(
            label: 'Mô tả cửa hàng',
            controller: _shopDescriptionController,
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          
          CustomTextField(
            label: 'Địa chỉ',
            controller: _shopAddressController,
            prefixIcon: const Icon(Icons.location_on_outlined),
          ),
          const SizedBox(height: 16),
          
          CustomTextField(
            label: 'Số điện thoại',
            controller: _shopPhoneController,
            keyboardType: TextInputType.phone,
            prefixIcon: const Icon(Icons.phone_outlined),
          ),
          const SizedBox(height: 16),
          
          CustomTextField(
            label: 'Email',
            controller: _shopEmailController,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.email_outlined),
          ),
          
          const SizedBox(height: 24),
          
          // Statistics
          Text(
            'Thống kê',
            style: AppTheme.heading3.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 12),
          
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Column(
              children: [
                InfoRow(label: 'Ngày tham gia', value: '01/01/2024'),
                const Divider(height: 24),
                InfoRow(label: 'Tổng sản phẩm', value: '67 sản phẩm'),
                const Divider(height: 24),
                InfoRow(label: 'Tổng đơn hàng', value: '1,234 đơn'),
                const Divider(height: 24),
                InfoRow(
                  label: 'Đánh giá',
                  value: '4.8 ⭐ (256 đánh giá)',
                  valueColor: AppTheme.warningColor,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildOwnerInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông tin chủ sở hữu',
            style: AppTheme.heading3.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 16),
          
          CustomTextField(
            label: 'Họ và tên',
            controller: _ownerNameController,
            prefixIcon: const Icon(Icons.person_outline),
          ),
          const SizedBox(height: 16),
          
          CustomTextField(
            label: 'Số điện thoại',
            controller: _ownerPhoneController,
            keyboardType: TextInputType.phone,
            prefixIcon: const Icon(Icons.phone_outlined),
          ),
          const SizedBox(height: 16),
          
          CustomTextField(
            label: 'Email',
            controller: _ownerEmailController,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.email_outlined),
          ),
          
          const SectionDivider(title: 'THÔNG TIN DOANH NGHIỆP'),
          
          CustomTextField(
            label: 'Mã số thuế',
            controller: _taxCodeController,
            prefixIcon: const Icon(Icons.business_outlined),
          ),
          const SizedBox(height: 16),
          
          CustomTextField(
            label: 'Số giấy phép kinh doanh',
            controller: _businessLicenseController,
            prefixIcon: const Icon(Icons.description_outlined),
          ),
          const SizedBox(height: 16),
          
          // Document Upload Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Giấy tờ pháp lý',
                  style: AppTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                _buildDocumentItem('Giấy phép kinh doanh', 'Đã tải lên', true),
                const SizedBox(height: 8),
                _buildDocumentItem('CMND/CCCD', 'Đã tải lên', true),
                const SizedBox(height: 8),
                _buildDocumentItem('Giấy chứng nhận ATTP', 'Chưa tải lên', false),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildBankInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.secondaryLight.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.secondaryDark),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: AppTheme.secondaryDark,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Thông tin này dùng để nhận thanh toán từ khách hàng',
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.secondaryDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          CustomTextField(
            label: 'Tên ngân hàng',
            controller: _bankNameController,
            prefixIcon: const Icon(Icons.account_balance),
          ),
          const SizedBox(height: 16),
          
          CustomTextField(
            label: 'Số tài khoản',
            controller: _bankAccountController,
            keyboardType: TextInputType.number,
            prefixIcon: const Icon(Icons.credit_card),
          ),
          const SizedBox(height: 16),
          
          CustomTextField(
            label: 'Tên chủ tài khoản',
            controller: _bankOwnerController,
            prefixIcon: const Icon(Icons.person_outline),
          ),
          const SizedBox(height: 24),
          
          // QR Code Section
          Text(
            'Mã QR thanh toán',
            style: AppTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.borderColor, width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.qr_code_2,
                    size: 120,
                    color: AppTheme.textLight,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tạo mã QR',
                    style: AppTheme.caption.copyWith(
                      color: AppTheme.textLight,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                // Generate QR code
              },
              icon: const Icon(Icons.qr_code),
              label: const Text('Tạo mã QR thanh toán'),
            ),
          ),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildDocumentItem(String title, String status, bool isUploaded) {
    return Row(
      children: [
        Icon(
          isUploaded ? Icons.check_circle : Icons.upload_file,
          color: isUploaded ? AppTheme.successColor : AppTheme.textLight,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.bodySmall.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                status,
                style: AppTheme.caption.copyWith(
                  color: isUploaded ? AppTheme.successColor : AppTheme.textLight,
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            // Handle upload/view document
          },
          child: Text(isUploaded ? 'Xem' : 'Tải lên'),
        ),
      ],
    );
  }
}