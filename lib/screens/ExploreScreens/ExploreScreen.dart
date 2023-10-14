import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Uzaar/screens/ExploreScreens/explore_housing_screen.dart';

import 'package:Uzaar/utils/Colors.dart';

import '../../widgets/business_type_button.dart';
import '../../widgets/search_field.dart';
import 'ExploreProductsScreen.dart';
import 'ExploreServicesScreen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final searchController = TextEditingController();

  // final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int selectedCategory = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = 1;
                        });
                      },
                      child: BusinessTypeButton(
                        businessName: 'Products',
                        gradient: selectedCategory == 1 ? gradient : null,
                        buttonBackground: selectedCategory != 1
                            ? grey.withOpacity(0.3)
                            : null,
                        textColor: selectedCategory == 1 ? white : grey,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = 2;
                        });
                      },
                      child: BusinessTypeButton(
                        businessName: 'Services',
                        gradient: selectedCategory == 2 ? gradient : null,
                        buttonBackground: selectedCategory != 2
                            ? grey.withOpacity(0.3)
                            : null,
                        textColor: selectedCategory == 2 ? white : grey,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = 3;
                        });
                      },
                      child: BusinessTypeButton(
                        businessName: 'Housing',
                        gradient: selectedCategory == 3 ? gradient : null,
                        buttonBackground: selectedCategory != 3
                            ? grey.withOpacity(0.3)
                            : null,
                        textColor: selectedCategory == 3 ? white : grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                SearchField(searchController: searchController),
                SizedBox(
                  height: 20.h,
                ),
                selectedCategory == 1
                    ? ExploreProductsScreen()
                    : selectedCategory == 2
                        ? ExploreServicesScreen()
                        : ExploreHousingScreen(),
                // :
              ],
            ),
          ),
        ),
      ),
    );
  }
}
