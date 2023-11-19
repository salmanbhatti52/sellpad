import 'package:Uzaar/screens/BusinessDetailPages/product_details_page.dart';
import 'package:Uzaar/widgets/rounded_small_dropdown_menu.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Uzaar/utils/colors.dart';
import 'package:Uzaar/widgets/featured_products_widget.dart';

import '../../services/restService.dart';
import '../../utils/Buttons.dart';
import '../../widgets/alert_dialog_reusable.dart';
import '../../widgets/rounded_dropdown_menu.dart';

enum ReportReason { notInterested, notAuthentic, inappropriate, violent, other }

class ExploreProductsScreen extends StatefulWidget {
  const ExploreProductsScreen({super.key});

  @override
  State<ExploreProductsScreen> createState() => _ExploreProductsScreenState();
}

class _ExploreProductsScreenState extends State<ExploreProductsScreen> {
  late Set<ReportReason> selectedReasons = {};
  String? selectedCategory;
  String? selectedPrice;
  String? selectedLocation;

  final List<String> categories = [
    'Electronics',
    'Vehicles',
    'Books',
    'Accessories',
    'Furniture',
    'Fashion',
    'Sports',
  ];

  final List<String> locations = [
    'Multan',
    'Lahore',
    'Karachi',
  ];

  final List<String> prices = [
    '0-40',
    '40-80',
    '80-120',
    '120-160',
    '160-200',
    '200-240',
    '240-280',
    '280-320',
    '320-360',
    '360-400',
  ];

  handleOptionSelection(ReportReason reason) {
    if (selectedReasons.contains(reason)) {
      selectedReasons.remove(reason);
    } else {
      selectedReasons.add(reason);
    }
    print(selectedReasons);
  }

  @override
  Widget build(BuildContext context) {
    // return Container();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: Row(
              children: [
                RoundedSmallDropdownMenu(
                  width: 170,
                  leadingIconName: selectedCategory != null
                      ? 'cat-selected'
                      : 'cat-unselected',
                  hintText: 'Category',
                  onSelected: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                  dropdownMenuEntries: categories
                      .map(
                        (String value) => DropdownMenuEntry<String>(
                            value: value, label: value),
                      )
                      .toList(),
                ),
                // GestureDetector(
                //   onTap: () {
                //     setState(() {
                //       selectedCategory = !selectedCategory;
                //     });
                //   },
                //   child: Container(
                //     padding: EdgeInsets.symmetric(horizontal: 8.w),
                //     width: 140.w,
                //     height: 40.h,
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //         color: primaryBlue,
                //         width: 2,
                //       ),
                //       borderRadius: BorderRadius.circular(40),
                //     ),
                //     child: Row(
                //       children: [
                //         selectedCategory
                //             ? SvgPicture.asset('assets/cat-selcected.svg')
                //             : SvgPicture.asset('assets/cat-unselect.svg'),
                //         SizedBox(
                //           width: 4.w,
                //         ),
                //         DropdownButtonHideUnderline(
                //           child: DropdownButton2<String>(
                //             // isExpanded: true,
                //             hint: Text(
                //               'Category',
                //               style: GoogleFonts.outfit(
                //                 fontSize: 14,
                //                 fontWeight: FontWeight.w500,
                //                 color: primaryBlue,
                //               ),
                //             ),
                //             items: items
                //                 .map((String item) => DropdownMenuItem<String>(
                //                       value: item,
                //                       child: Text(
                //                         item,
                //                         style: GoogleFonts.outfit(
                //                           fontSize: 14,
                //                           fontWeight: FontWeight.w500,
                //                           color: primaryBlue,
                //                         ),
                //                         overflow: TextOverflow.ellipsis,
                //                       ),
                //                     ))
                //                 .toList(),
                //             value: selectedValue,
                //             onChanged: (value) {
                //               setState(() {
                //                 selectedValue = value;
                //               });
                //             },
                //
                //             iconStyleData: IconStyleData(
                //               icon:
                //                   SvgPicture.asset('assets/drop-down-button.svg'),
                //               iconEnabledColor: primaryBlue,
                //               iconDisabledColor: grey,
                //             ),
                //             dropdownStyleData: DropdownStyleData(
                //               maxHeight: 200.h,
                //               width: 140.w,
                //               decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(14),
                //                 color: white,
                //               ),
                //               offset: const Offset(-20, 0),
                //               scrollbarTheme: ScrollbarThemeData(
                //                 radius: const Radius.circular(40),
                //                 thickness: MaterialStateProperty.all(6),
                //                 thumbVisibility: MaterialStateProperty.all(true),
                //               ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(
                  width: 10.w,
                ),

                RoundedSmallDropdownMenu(
                  width: 150,
                  leadingIconName:
                      selectedPrice != null ? 'cat-selected' : 'cat-unselected',
                  hintText: 'Price',
                  onSelected: (value) {
                    setState(() {
                      selectedPrice = value;
                    });
                  },
                  dropdownMenuEntries: prices
                      .map(
                        (String value) => DropdownMenuEntry<String>(
                            value: value, label: value),
                      )
                      .toList(),
                ),
                SizedBox(
                  width: 10.w,
                ),
                RoundedSmallDropdownMenu(
                  // trailingIconName: 'blue_address_icon',
                  width: 170,
                  leadingIconName: selectedLocation != null
                      ? 'cat-selected'
                      : 'cat-unselected',
                  hintText: 'Location',
                  onSelected: (value) {
                    setState(() {
                      selectedLocation = value;
                    });
                  },
                  dropdownMenuEntries: locations
                      .map(
                        (String value) => DropdownMenuEntry<String>(
                            value: value, label: value),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Featured Products',
            style: kBodyHeadingTextStyle,
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.46,
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: primaryBlue,
            child: GridView.builder(
              // padding: EdgeInsets.only(bottom: 33, left: 8),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 187,----------------------------------------
              ),
              itemCount: featuredProductsGV.length,
              itemBuilder: (context, index) {
                return FeaturedProductsWidget(
                  productConditon: featuredProductsGV[index]['condition'],
                  image: imgBaseUrl +
                      featuredProductsGV[index]['listings_images'][0]['image'],
                  productCategory: featuredProductsGV[index]
                      ['listings_categories']['name'],
                  productDescription: featuredProductsGV[index]['name'],
                  productLocation: 'California',
                  productPrice: featuredProductsGV[index]['price'],
                  onImageTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(),
                      ),
                    );
                  },
                  onOptionTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => StatefulBuilder(
                        builder: (BuildContext context,
                            StateSetter stateSetterObject) {
                          return AlertDialogReusable(
                              description:
                                  'Select any reason to report. We will show you less listings like this next time.',
                              title: 'Report Listing',
                              itemsList: [
                                SizedBox(
                                  height: 35,
                                  child: ListTile(
                                    title: Text(
                                      'Not Interested',
                                      style: kTextFieldInputStyle,
                                    ),
                                    leading: GestureDetector(
                                      onTap: () {
                                        stateSetterObject(() {
                                          handleOptionSelection(
                                              ReportReason.notInterested);
                                        });
                                      },
                                      child: SvgPicture.asset(
                                          selectedReasons.contains(
                                                  ReportReason.notInterested)
                                              ? 'assets/selected_check.svg'
                                              : 'assets/default_check.svg'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                  child: ListTile(
                                    title: Text(
                                      'Not Authentic',
                                      style: kTextFieldInputStyle,
                                    ),
                                    leading: GestureDetector(
                                      onTap: () {
                                        stateSetterObject(() {
                                          handleOptionSelection(
                                              ReportReason.notAuthentic);
                                        });
                                      },
                                      child: SvgPicture.asset(
                                          selectedReasons.contains(
                                                  ReportReason.notAuthentic)
                                              ? 'assets/selected_check.svg'
                                              : 'assets/default_check.svg'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                  child: ListTile(
                                    title: Text(
                                      'Inappropriate',
                                      style: kTextFieldInputStyle,
                                    ),
                                    leading: GestureDetector(
                                      onTap: () {
                                        stateSetterObject(() {
                                          handleOptionSelection(
                                              ReportReason.inappropriate);
                                        });
                                      },
                                      child: SvgPicture.asset(
                                          selectedReasons.contains(
                                                  ReportReason.inappropriate)
                                              ? 'assets/selected_check.svg'
                                              : 'assets/default_check.svg'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                  child: ListTile(
                                    title: Text(
                                      'Violent or prohibited content',
                                      style: kTextFieldInputStyle,
                                    ),
                                    leading: GestureDetector(
                                      onTap: () {
                                        stateSetterObject(() {
                                          handleOptionSelection(
                                              ReportReason.violent);
                                        });
                                      },
                                      child: SvgPicture.asset(selectedReasons
                                              .contains(ReportReason.violent)
                                          ? 'assets/selected_check.svg'
                                          : 'assets/default_check.svg'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                  child: ListTile(
                                    title: Text(
                                      'Other',
                                      style: kTextFieldInputStyle,
                                    ),
                                    leading: GestureDetector(
                                      onTap: () {
                                        stateSetterObject(() {
                                          handleOptionSelection(
                                              ReportReason.other);
                                        });
                                      },
                                      child: SvgPicture.asset(selectedReasons
                                              .contains(ReportReason.other)
                                          ? 'assets/selected_check.svg'
                                          : 'assets/default_check.svg'),
                                    ),
                                  ),
                                ),
                              ],
                              button: primaryButton(
                                  context: context,
                                  buttonText: 'Send',
                                  onTap: () => Navigator.of(context).pop(),
                                  showLoader: false));
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
