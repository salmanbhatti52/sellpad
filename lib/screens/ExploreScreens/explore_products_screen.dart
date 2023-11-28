import 'dart:convert';

import 'package:Uzaar/screens/BusinessDetailPages/product_details_page.dart';
import 'package:Uzaar/widgets/rounded_small_dropdown_menu.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Uzaar/utils/colors.dart';
import 'package:Uzaar/widgets/featured_products_widget.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';

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

  getAllProducts() async {
    Response response = await sendGetRequest('get_all_listings_products');
    print(response.statusCode);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    allListingsProductsGV = decodedResponse['data'];
    if (mounted) {
      setState(() {});
    }
    print('allListingsProductsGV: $allListingsProductsGV');
  }

  init() async {
    await getAllProducts();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    // return Container();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5.0),
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
                  SizedBox(
                    width: 10.w,
                  ),
                  RoundedSmallDropdownMenu(
                    width: 150,
                    leadingIconName: selectedPrice != null
                        ? 'cat-selected'
                        : 'cat-unselected',
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
              child: allListingsProductsGV != null
                  ? GridView.builder(
                      padding: EdgeInsets.only(bottom: 33, left: 2),
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 187,
                      ),
                      itemCount: allListingsProductsGV.length,
                      itemBuilder: (context, index) {
                        return FeaturedProductsWidget(
                          productCondition: allListingsProductsGV[index]
                              ['condition'],
                          image: imgBaseUrl +
                              allListingsProductsGV[index]['listings_images'][0]
                                  ['image'],
                          productCategory: allListingsProductsGV[index]
                              ['listings_categories']['name'],
                          productName: allListingsProductsGV[index]['name'],
                          productLocation: 'California',
                          productPrice: allListingsProductsGV[index]['price'],
                          onImageTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsPage(
                                  productData: allListingsProductsGV[index],
                                ),
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
                                                      ReportReason
                                                          .notInterested);
                                                });
                                              },
                                              child: SvgPicture.asset(selectedReasons
                                                      .contains(ReportReason
                                                          .notInterested)
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
                                                      ReportReason
                                                          .notAuthentic);
                                                });
                                              },
                                              child: SvgPicture.asset(selectedReasons
                                                      .contains(ReportReason
                                                          .notAuthentic)
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
                                                      ReportReason
                                                          .inappropriate);
                                                });
                                              },
                                              child: SvgPicture.asset(selectedReasons
                                                      .contains(ReportReason
                                                          .inappropriate)
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
                                                      .contains(
                                                          ReportReason.violent)
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
                                                      .contains(
                                                          ReportReason.other)
                                                  ? 'assets/selected_check.svg'
                                                  : 'assets/default_check.svg'),
                                            ),
                                          ),
                                        ),
                                      ],
                                      button: primaryButton(
                                          context: context,
                                          buttonText: 'Send',
                                          onTap: () =>
                                              Navigator.of(context).pop(),
                                          showLoader: false));
                                },
                              ),
                            );
                          },
                        );
                      },
                    )
                  : Shimmer.fromColors(
                      child: GridView.builder(
                        padding: EdgeInsets.only(bottom: 33, left: 2),
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 187,
                        ),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return FeaturedProductsDummy();
                        },
                      ),
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!),
            ),
          )
        ],
      ),
    );
  }
}
