import 'package:flutter/material.dart';
import 'package:stor_app/home/ui/home_page.dart';
import 'package:stor_app/packeges/utils/material.dart';

class MainHostPage extends StatefulWidget {
  const MainHostPage({super.key});

  @override
  State<MainHostPage> createState() => _MainHostPageState();
}

class _MainHostPageState extends State<MainHostPage> {
  final PageController controller = PageController(initialPage: 1);
  int currentIndex = 0;
  final tabPages = [
    const _Tabbar2(),
    const HomePage(),
    const _SettingPage(),
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

class _Tabbar2 extends StatefulWidget {
  const _Tabbar2();

  @override
  State<_Tabbar2> createState() => _Tabbar2State();
}

class _Tabbar2State extends State<_Tabbar2>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: const Center(
        child: Text('Cart Page'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _SettingPage extends StatefulWidget {
  const _SettingPage();

  @override
  State<_SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<_SettingPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Setting')),
      body: const Center(
        child: Text('Setting Page'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
