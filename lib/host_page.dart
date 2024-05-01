import 'package:flutter/material.dart';
import 'package:stor_app/home/home_page.dart';
import 'package:stor_app/packeges/utils/material.dart';

class MainHostPage extends StatefulWidget {
  const MainHostPage({super.key});

  @override
  State<MainHostPage> createState() => _MainHostPageState();
}

class _MainHostPageState extends State<MainHostPage> {
  final PageController controller = PageController();
  int currentIndex = 0;
  final tabPages = [
    const HomePage(),
    const _Tabbar2(),
  ];

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
        selectedItemColor: AppColor.brown,
        onTap: (index) {
          controller.jumpToPage(index);

          /// Switching the PageView tabs
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}


class _Tabbar2 extends StatefulWidget {
  const _Tabbar2({super.key});

  @override
  State<_Tabbar2> createState() => _Tabbar2State();
}

class _Tabbar2State extends State<_Tabbar2>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Tab bar 2')),
      body: const Center(
        child: Text('A'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
