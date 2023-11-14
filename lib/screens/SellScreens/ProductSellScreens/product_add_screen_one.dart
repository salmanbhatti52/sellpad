import 'package:Uzaar/widgets/navigate_back_icon.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Uzaar/screens/SellScreens/ProductSellScreens/product_add_screen_two.dart';
import 'package:Uzaar/utils/Buttons.dart';
import 'package:Uzaar/utils/colors.dart';

import '../../../widgets/text_form_field_reusable.dart';
import '../../../widgets/rounded_dropdown_menu.dart';
import '../../../widgets/suffix_svg_icon.dart';
import '../../../widgets/tab_indicator.dart';
import '../../../widgets/text.dart';

enum ProductConditions { fresh, used }

class ProductAddScreenOne extends StatefulWidget {
  static const String id = 'product_add_screen_one';
  ProductAddScreenOne({super.key, this.editDetails});
  bool? editDetails;

  @override
  State<ProductAddScreenOne> createState() => _ProductAddScreenOneState();
}

class _ProductAddScreenOneState extends State<ProductAddScreenOne> {
  int noOfTabs = 3;

  final nameEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();
  final priceEditingController = TextEditingController();

  List<String> productCategories = [
    'Electronic',
    'Vehicle',
    'Fashion',
    'Books'
  ];
  late String? dropDownValue;

  ProductConditions _selectedProductCondition = ProductConditions.fresh;
  updateSelectedCondition(value) {
    _selectedProductCondition = value;
    print(_selectedProductCondition);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropDownValue = productCategories.first;
  }

  List<Widget> getPageIndicators() {
    List<Widget> tabs = [];

    for (int i = 1; i <= noOfTabs; i++) {
      final tab = TabIndicator(
        color: i == 2 ? null : grey,
        gradient: i == 2 ? gradient : null,
        margin: i == noOfTabs ? null : EdgeInsets.only(right: 10),
      );
      tabs.add(tab);
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: NavigateBack(buildContext: context),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 22.0.w),
              child: Column(
                children: [
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: getPageIndicators(),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Product Name'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 46,
                        child: TextFormFieldWidget(
                          controller: nameEditingController,
                          textInputType: TextInputType.text,
                          prefixIcon:
                              SvgIcon(imageName: 'assets/product_icon.svg'),
                          hintText: 'Product Name',
                          obscureText: null,
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Category'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      RoundedDropdownMenu(
                          width: MediaQuery.sizeOf(context).width * 0.887,
                          leadingIconName: 'category_icon',
                          hintText: 'Category',
                          onSelected: (value) {
                            setState(() {
                              dropDownValue = value;
                            });
                          },
                          dropdownMenuEntries: productCategories
                              .map(
                                (String value) => DropdownMenuEntry<String>(
                                    value: value, label: value),
                              )
                              .toList()),
                      SizedBox(
                        height: 14.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Condition'),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      SizedBox(
                        height: 35,
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Radio(
                                  activeColor: primaryBlue,
                                  fillColor:
                                      MaterialStatePropertyAll(primaryBlue),
                                  value: ProductConditions.fresh,
                                  groupValue: _selectedProductCondition,
                                  onChanged: (value) {
                                    setState(() {
                                      updateSelectedCondition(value);
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  'New',
                                  style: kTextFieldInputStyle,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Row(
                              children: [
                                Radio(
                                  activeColor: primaryBlue,
                                  fillColor:
                                      MaterialStatePropertyAll(primaryBlue),
                                  value: ProductConditions.used,
                                  groupValue: _selectedProductCondition,
                                  onChanged: (value) {
                                    setState(() {
                                      updateSelectedCondition(value);
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  'Used',
                                  style: kTextFieldInputStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Product Description'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 46,
                        child: TextFormFieldWidget(
                          controller: descriptionEditingController,
                          textInputType: TextInputType.text,
                          prefixIcon:
                              SvgIcon(imageName: 'assets/description_icon.svg'),
                          hintText: 'Description here',
                          obscureText: null,
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Price'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 46,
                        child: TextFormFieldWidget(
                          controller: priceEditingController,
                          textInputType: TextInputType.number,
                          prefixIcon:
                              SvgIcon(imageName: 'assets/tag_price_bold.svg'),
                          hintText: 'Enter Price',
                          obscureText: null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14.0),
                    child: primaryButton(
                        context: context,
                        buttonText: 'Next',
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ProductAddScreenTwo(
                                    editDetails: widget.editDetails,
                                  );
                                },
                              ),
                            ),
                        showLoader: false),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageWithText extends StatelessWidget {
  const ImageWithText({
    super.key,
    required this.text,
    required this.onTap,
    required this.imageName,
  });
  // final String imageName;
  final String text;

  final void Function()? onTap;
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgIcon(imageName: 'assets/$imageName.svg'),
          // SvgIcon(imageName: 'assets/radio_blank.svg'),
          SizedBox(
            width: 15.w,
          ),
          Text(
            text,
            style: kTextFieldInputStyle,
          )
        ],
      ),
    );
  }
}
