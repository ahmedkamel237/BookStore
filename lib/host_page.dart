import 'package:flutter/material.dart';
import 'package:stor_app/cart/ui/cart_page.dart';
import 'package:stor_app/home/ui/home_page.dart';
import 'package:stor_app/packeges/utils/material.dart';
import 'package:stor_app/setting/setting_page.dart';

class MainHostPage extends StatefulWidget {
  const MainHostPage({super.key});

  @override
  State<MainHostPage> createState() => _MainHostPageState();
}

class _MainHostPageState extends State<MainHostPage> {
  final PageController controller = PageController(initialPage: 1);
  int currentIndex = 0;
  final tabPages = [
    const CartPage(),
    const HomePage(),
    const SettingPage(),
  ];


  @override
  void initState() {
    currentIndex = 1;
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
            /// Switching bottom tabs
          });
        },
        children: tabPages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: AppColors.brown,
        onTap: (index) {
          controller.jumpToPage(index);
          /// Switching the PageView tabs
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
