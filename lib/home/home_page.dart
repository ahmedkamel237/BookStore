import 'package:flutter/material.dart';
import 'package:stor_app/packeges/utils/material.dart';
import 'package:stor_app/packeges/utils/src/dimensions/padding_dimensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Store',
          style: TextStyle(
            color: AppColor.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.3,
            width: double.infinity,
            child: Image.asset(
              'assets/store_app_background.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.12,
            child: ListView.separated(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: PaddingDimensions.pagePadding,
              ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                height: MediaQuery.sizeOf(context).height * 0.1 -
                    PaddingDimensions.normal,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColor.brown,
                  ),
                ),
                width: MediaQuery.sizeOf(context).height * 0.1 -
                    PaddingDimensions.normal,
                child: Image.asset(
                  'assets/store_app_background.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(
                width: PaddingDimensions.normal,
              ),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
