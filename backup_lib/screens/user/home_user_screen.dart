import 'package:flutter/material.dart';
import '../../widgets/user/home/app_header.dart';
import '../../widgets/user/home/search_bar.dart';
import '../../widgets/user/home/flash_sale_section.dart';
import '../../widgets/user/home/category_section.dart';
import '../../widgets/user/component/product_list_section.dart';
import '../../widgets/user/home/live_stream_banner.dart';
import '../../widgets/user/component/ai_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              AppHeader(),
              CustomSearchBar(),
              FlashSaleSection(),
              CategorySection(),
              ProductListSection(),
              LiveStreamBanner(),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButton: AI_Button(),
    );
  }
}