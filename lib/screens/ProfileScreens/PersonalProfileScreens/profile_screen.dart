import 'package:Uzaar/screens/ProfileScreens/PersonalProfileScreens/profile_reviews_screen.dart';
import 'package:Uzaar/screens/ProfileScreens/edit_profile_screen.dart';
import 'package:Uzaar/screens/ProfileScreens/apply_for_verification_screen.dart';

import 'package:Uzaar/widgets/get_stars_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Uzaar/utils/colors.dart';

import '../../../services/restService.dart';
import '../../../widgets/DrawerWidget.dart';
import '../../../widgets/business_type_button.dart';
import '../../../widgets/suffix_svg_icon.dart';
import '../../../widgets/text.dart';
import '../../../widgets/text_form_field_reusable.dart';
import '../../chat_list_screen.dart';
import '../../notifications_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  int selectedCategory = 1;
  // final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstNameController.text = userDataGV['firstName'];
    lastNameController.text = userDataGV['lastName'];
    emailController.text = userDataGV['email'];
    phoneNumberController.text = userDataGV['phoneNumber'] ?? '';
    addressController.text = userDataGV['address'] ?? '';
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
          iconTheme: IconThemeData(color: black),
          elevation: 0.0,
          backgroundColor: Colors.white,
          leadingWidth: 70,
          leading: Builder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 20),
                child: GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: SvgPicture.asset(
                    'assets/drawer-button.svg',
                    fit: BoxFit.scaleDown,
                  ),
                ),
              );
            },
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MessagesScreen(),
                      ),
                    ),
                    child: SvgPicture.asset(
                      'assets/msg-icon.svg',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NotificationScreen(),
                      ),
                    ),
                    child: SvgPicture.asset(
                      'assets/notification-icon.svg',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ],
              ),
            ),
          ],
          centerTitle: false,
          title: Text(
            'Profile',
            style: kAppBarTitleStyle,
          ),
        ),
        drawer: DrawerWidget(
          buildContext: context,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: primaryBlue,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topEnd,
                      child: GestureDetector(
                        onTap: () async {
                          var data = await Navigator.of(context)
                              .push(MaterialPageRoute(
                            builder: (context) => EditProfileScreen(),
                          ));
                          print('Data Recieved: $data');

                          firstNameController.text = userDataGV['firstName'];
                          lastNameController.text = userDataGV['lastName'];
                          emailController.text = userDataGV['email'];
                          phoneNumberController.text =
                              userDataGV['phoneNumber'] ?? '';
                          addressController.text = userDataGV['address'] ?? '';
                        },
                        child: SvgPicture.asset(
                          'assets/edit_profile.svg',
                        ),
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      // alignment: Alignment.bottomRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            'assets/dummy_profile.png',
                          ),
                        ),
                        Positioned(
                          left: -10,
                          top: -7,
                          child: GestureDetector(
                            onTap: null,
                            child: SvgPicture.asset(
                              'assets/verified_icon.svg',
                            ),
                          ),
                        ),
                        Positioned(
                          right: -7,
                          bottom: -1,
                          child: GestureDetector(
                            onTap: null,
                            child: SvgPicture.asset(
                              'assets/add-pic-button.svg',
                              // fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ApplyForVerificationScreen(),
                      )),
                      child: Text(
                        'Apply for Verification',
                        textAlign: TextAlign.center,
                        style: kFontSixteenSixHPB,
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    StarsTile(
                      noOfStars: 5,
                      alignment: MainAxisAlignment.center,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '(14)',
                      style: kFontSixteenSixHB,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = 1;
                            });
                          },
                          child: BusinessTypeButton(
                            width: 100,
                            businessName: 'Personal Info',
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
                            width: 100,
                            businessName: 'Reviews',
                            gradient: selectedCategory == 2 ? gradient : null,
                            buttonBackground: selectedCategory != 2
                                ? grey.withOpacity(0.3)
                                : null,
                            textColor: selectedCategory == 2 ? white : grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    selectedCategory == 1
                        ? Container(
                            margin: EdgeInsets.only(bottom: 22),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: ReusableText(text: 'First Name'),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                  height: 46,
                                  child: TextFormFieldWidget(
                                    readOnly: true,
                                    controller: firstNameController,
                                    textInputType: TextInputType.name,
                                    prefixIcon: SvgPicture.asset(
                                      'assets/person-icon.svg',
                                      fit: BoxFit.scaleDown,
                                    ),
                                    hintText: 'First Name',
                                    obscureText: null,
                                  ),
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: ReusableText(text: 'Last Name')),
                                SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                  height: 46,
                                  child: TextFormFieldWidget(
                                    readOnly: true,
                                    controller: lastNameController,
                                    textInputType: TextInputType.name,
                                    prefixIcon: SvgPicture.asset(
                                      'assets/person-icon.svg',
                                      fit: BoxFit.scaleDown,
                                    ),
                                    hintText: 'Last Name',
                                    obscureText: null,
                                  ),
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: ReusableText(text: 'Email')),
                                SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                  height: 46,
                                  child: TextFormFieldWidget(
                                    readOnly: true,
                                    controller: emailController,
                                    textInputType: TextInputType.emailAddress,
                                    prefixIcon: SvgPicture.asset(
                                      'assets/email-icon.svg',
                                      fit: BoxFit.scaleDown,
                                    ),
                                    hintText: 'username@gmail.com',
                                    obscureText: null,
                                  ),
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: ReusableText(text: 'Phone Number')),
                                SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                  height: 46,
                                  child: TextFormFieldWidget(
                                    readOnly: true,
                                    controller: phoneNumberController,
                                    textInputType: TextInputType.phone,
                                    prefixIcon: SvgIcon(
                                        imageName: 'assets/phone-fill.svg'),
                                    hintText: '+4156565662',
                                    obscureText: null,
                                  ),
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: ReusableText(text: 'Address')),
                                SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                  height: 46,
                                  child: TextFormFieldWidget(
                                    readOnly: true,
                                    controller: addressController,
                                    textInputType: TextInputType.streetAddress,
                                    prefixIcon: SvgPicture.asset(
                                      'assets/address-icon.svg',
                                      fit: BoxFit.scaleDown,
                                    ),
                                    suffixIcon: SvgPicture.asset(
                                      'assets/address-icon.svg',
                                      fit: BoxFit.scaleDown,
                                      colorFilter: ColorFilter.mode(
                                          primaryBlue, BlendMode.srcIn),
                                    ),
                                    hintText: 'Address',
                                    obscureText: null,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ProfileReviewsScreen()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
