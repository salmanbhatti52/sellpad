import 'dart:convert';

import 'package:Uzaar/widgets/navigate_back_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

import '../../../services/location.dart';
import '../../../services/restService.dart';
import '../../../utils/Buttons.dart';
import '../../../utils/colors.dart';
import '../../../widgets/BottomNaviBar.dart';
import '../../../widgets/snackbars.dart';
import '../../../widgets/text_form_field_reusable.dart';
import '../../../widgets/rounded_dropdown_menu.dart';
import '../../../widgets/suffix_svg_icon.dart';
import '../../../widgets/tab_indicator.dart';
import '../../../widgets/text.dart';

enum FurnishedConditions { yes, no }

class HouseEditScreen extends StatefulWidget {
  const HouseEditScreen(
      {super.key, required this.listingData, required this.imagesList});
  final dynamic listingData;
  final List<Map<String, dynamic>> imagesList;
  @override
  State<HouseEditScreen> createState() => _HouseEditScreenState();
}

class _HouseEditScreenState extends State<HouseEditScreen> {
  int noOfTabs = 2;
  late String? selectedCategoryName = '';
  late String? selectedCategoryId = '';
  late String? selectedBoostingOption = '';
  late int? selectedBedroomOption = 0;
  late int? selectedBathroomOption = 0;
  final nameEditingController = TextEditingController();
  final locationEditingController = TextEditingController();
  final priceEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();
  final areaEditingController = TextEditingController();
  List<Map<String, String>> housingCategories = [
    {'categoryName': 'Rental', 'categoryId': '13'},
    {'categoryName': 'For Sale', 'categoryId': '14'},
    {'categoryName': 'Lease', 'categoryId': '15'},
  ];
  List<String> boostingOptions = ['Free', 'Paid'];
  List<int> bedrooms = [1, 2, 3, 4, 5];
  List<int> bathrooms = [1, 2, 3, 4, 5];

  late double latitude;
  late double longitude;
  late Position position;
  bool setLoader = false;
  String setButtonStatus = 'Save Changes';
  Object? initialCategoryValue;
  Object? initialBedroomsValue;
  Object? initialBathroomsValue;
  FurnishedConditions? _selectedCondition = FurnishedConditions.no;

  updateSelectedCondition(value) {
    _selectedCondition = value;
    print(_selectedCondition);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addDataToFields();
  }

  addDataToFields() {
    nameEditingController.text = widget.listingData['name'];
    descriptionEditingController.text = widget.listingData['description'];
    priceEditingController.text = widget.listingData['price'];
    locationEditingController.text = widget.listingData['location'];
    areaEditingController.text = widget.listingData['area'];

    // _selectedCondition = widget.listingData['condition'] == 'New'
    //     ? ProductConditions.fresh
    //     : ProductConditions.used;
    int categoryIndex = housingCategories.indexWhere((map) =>
        map['categoryName'] ==
        widget.listingData['listings_categories']['name']);
    initialCategoryValue = housingCategories[categoryIndex];
    updateSelectedCategory(initialCategoryValue);

    int bedroomsValIndex =
        bedrooms.indexOf(int.parse(widget.listingData['bedroom']));
    initialBedroomsValue = bedrooms[bedroomsValIndex];
    print(initialBedroomsValue);
    updateBedroomsValue(initialBedroomsValue);

    int bathroomsValIndex =
        bathrooms.indexOf(int.parse(widget.listingData['bathroom']));
    initialBathroomsValue = bathrooms[bathroomsValIndex];
    print(initialBathroomsValue);
    updateBathroomsValue(initialBathroomsValue);
  }

  updateSelectedCategory(value) {
    selectedCategoryName = value['categoryName'];
    selectedCategoryId = value['categoryId'];
    print(selectedCategoryName);
    print(selectedCategoryId);
  }

  updateBedroomsValue(value) {
    selectedBedroomOption = value;
  }

  updateBathroomsValue(value) {
    selectedBathroomOption = value;
  }

  List<Widget> getPageIndicators() {
    List<Widget> tabs = [];

    for (int i = 1; i <= noOfTabs; i++) {
      final tab = TabIndicator(
        color: i == 2 ? null : grey,
        gradient: i == 2 ? gradient : null,
        margin: i == noOfTabs ? null : EdgeInsets.only(right: 10.w),
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.0.w),
              child: Column(
                children: [
                  Column(
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
                        child: ReusableText(text: 'House Name'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 46,
                        child: TextFormFieldWidget(
                          focusedBorder: kRoundedActiveBorderStyle,
                          controller: nameEditingController,
                          textInputType: TextInputType.text,
                          prefixIcon:
                              SvgIcon(imageName: 'assets/list_icon.svg'),
                          hintText: 'House Name',
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
                          hintText: 'Rental',
                          onSelected: updateSelectedCategory,
                          initialSelection: initialCategoryValue,
                          dropdownMenuEntries: housingCategories
                              .map(
                                (Map<String, String> value) =>
                                    DropdownMenuEntry<Object?>(
                                        value: value,
                                        label: value['categoryName'] ?? ''),
                              )
                              .toList()),
                      SizedBox(
                        height: 14.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Furnished'),
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
                                  value: FurnishedConditions.yes,
                                  groupValue: _selectedCondition,
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
                                  'Yes',
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
                                  value: FurnishedConditions.no,
                                  groupValue: _selectedCondition,
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
                                  'No',
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
                        child: ReusableText(text: 'Location'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 46,
                        child: TextFormFieldWidget(
                          focusedBorder: kRoundedActiveBorderStyle,
                          controller: locationEditingController,
                          textInputType: TextInputType.streetAddress,
                          prefixIcon:
                              SvgIcon(imageName: 'assets/address-icon.svg'),
                          suffixIcon: GestureDetector(
                            onTap: () async {
                              try {
                                await enableLocationService();
                                position = await getLocationCoordinates();
                                print(position);

                                List<Placemark> placemarks =
                                    await getLocationFromCoordinates(
                                        position.latitude, position.longitude);
                                print(placemarks);
                                print(
                                    '${placemarks[0].subLocality!}, ${placemarks[0].locality!}, ${placemarks[0].subAdministrativeArea!}, ${placemarks[0].administrativeArea!}, ${placemarks[0].country!}');
                                setState(() {
                                  locationEditingController.text =
                                      '${placemarks[0].subLocality!}, ${placemarks[0].locality!}, ${placemarks[0].subAdministrativeArea!}, ${placemarks[0].administrativeArea!}, ${placemarks[0].country!}';
                                });
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    ErrorSnackBar(message: e.toString()));
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //     ErrorSnackBar(
                                //         message:
                                //             'Plz check your device location is on'));
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //     AlertSnackBar(
                                //         message:
                                //             'we need permission to access your location'));
                              }
                            },
                            child: SvgIcon(
                              imageName: 'assets/address-icon.svg',
                              colorFilter: ColorFilter.mode(
                                  primaryBlue, BlendMode.srcIn),
                            ),
                          ),
                          hintText: 'Location here',
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
                          focusedBorder: kRoundedActiveBorderStyle,
                          controller: priceEditingController,
                          textInputType: TextInputType.number,
                          prefixIcon:
                              SvgIcon(imageName: 'assets/tag_price_bold.svg'),
                          hintText: 'Enter Price',
                          obscureText: null,
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(text: 'Description'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 46,
                        child: TextFormFieldWidget(
                          focusedBorder: kRoundedActiveBorderStyle,
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
                        child: ReusableText(text: 'Area'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 46,
                        child: TextFormFieldWidget(
                          focusedBorder: kRoundedActiveBorderStyle,
                          controller: areaEditingController,
                          textInputType: TextInputType.number,
                          prefixIcon:
                              SvgIcon(imageName: 'assets/area_icon.svg'),
                          hintText: 'Area ( Sq.ft)',
                          obscureText: null,
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: ReusableText(text: 'Bedroom'),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                RoundedDropdownMenu(
                                    width: MediaQuery.of(context).size.width *
                                        0.42,
                                    leadingIconName: 'bed_icon',
                                    hintText: '2',
                                    initialSelection: initialBedroomsValue,
                                    onSelected: updateBedroomsValue,
                                    dropdownMenuEntries: bedrooms
                                        .map(
                                          (int value) => DropdownMenuEntry<int>(
                                              value: value,
                                              label: value.toString()),
                                        )
                                        .toList()),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: ReusableText(text: 'Bathroom'),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                RoundedDropdownMenu(
                                    width: MediaQuery.of(context).size.width *
                                        0.42,
                                    leadingIconName: 'bath_icon',
                                    hintText: '2',
                                    initialSelection: initialBathroomsValue,
                                    onSelected: updateBathroomsValue,
                                    dropdownMenuEntries: bathrooms
                                        .map(
                                          (int value) => DropdownMenuEntry<int>(
                                              value: value,
                                              label: value.toString()),
                                        )
                                        .toList()),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Text(
                        '*Boost your listings now to get more orders or you can boost later',
                        style: kTextFieldInputStyle,
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:
                            ReusableText(text: 'Boosting Options (Optional)'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      RoundedDropdownMenu(
                          width: MediaQuery.sizeOf(context).width * 0.887,
                          leadingIconName: 'boost_icon',
                          hintText: 'Select Option',
                          onSelected: (value) {
                            setState(() {
                              selectedBoostingOption = value;
                            });
                          },
                          dropdownMenuEntries: boostingOptions
                              .map(
                                (String value) => DropdownMenuEntry<String>(
                                    value: value, label: value),
                              )
                              .toList()),
                      SizedBox(
                        height: 14.h,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14.0),
                    child: primaryButton(
                        context: context,
                        buttonText: setButtonStatus,
                        onTap: () async {
                          if (nameEditingController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message: 'Plz enter your house name'));
                          } else if (selectedCategoryName == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message: 'Plz select your house category'));
                          } else if (locationEditingController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message: 'Plz add your location'));
                          } else if (priceEditingController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message: 'Plz enter your house price'));
                          } else if (descriptionEditingController
                              .text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message:
                                        'Plz enter your house description'));
                          } else if (areaEditingController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message: 'Plz add your house area'));
                          } else if (selectedBedroomOption == 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message: 'Plz select no. of bedrooms'));
                          } else if (selectedBathroomOption == 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ErrorSnackBar(
                                    message: 'Plz select no. of bathrooms'));
                          } else {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            print(
                                'address: ${locationEditingController.text.toString()}');
                            setState(() {
                              setLoader = true;
                              setButtonStatus = 'Please wait..';
                            });
                            try {
                              List<Location> locations =
                                  await locationFromAddress(
                                      locationEditingController.text
                                          .toString());
                              print(locations);
                              print(locations[0].longitude);
                              print(locations[0].latitude);
                              latitude = locations[0].latitude;
                              longitude = locations[0].longitude;

                              Response response = await sendPostRequest(
                                  action: 'edit_listings_housings',
                                  data: {
                                    'listings_housings_id': widget
                                        .listingData['listings_housings_id'],
                                    'listings_categories_id':
                                        selectedCategoryId,
                                    'name':
                                        nameEditingController.text.toString(),
                                    'description': descriptionEditingController
                                        .text
                                        .toString(),
                                    'price':
                                        priceEditingController.text.toString(),
                                    'location': locationEditingController.text
                                        .toString(),
                                    'latitude': latitude.toString(),
                                    'longitude': longitude.toString(),
                                    'area':
                                        areaEditingController.text.toString(),
                                    'bedroom': selectedBedroomOption.toString(),
                                    'bathroom':
                                        selectedBathroomOption.toString(),
                                    'packages_id': '',
                                    // 'payment_gateways_id': '',
                                    // 'payment_status': '',
                                    'listings_images': widget.imagesList
                                  });
                              setState(() {
                                setLoader = false;
                                setButtonStatus = 'Save Changes';
                              });
                              print(response.statusCode);
                              print(response.body);
                              var decodedResponse = jsonDecode(response.body);
                              String status = decodedResponse['status'];
                              if (status == 'success') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        backgroundColor: primaryBlue,
                                        content: Text(
                                          'Success',
                                          style: kToastTextStyle,
                                        )));
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return BottomNavBar();
                                    },
                                  ),
                                  (route) => false,
                                );
                              }
                              if (status == 'error') {
                                String message = decodedResponse?['message'];
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          message,
                                          style: kToastTextStyle,
                                        )));
                              }
                            } catch (e) {
                              print(e);
                              setState(() {
                                setLoader = false;
                                setButtonStatus = 'Save Changes';
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'Plz enter a valid address',
                                        style: kToastTextStyle,
                                      )));
                            }
                          }
                        },
                        showLoader: setLoader),
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