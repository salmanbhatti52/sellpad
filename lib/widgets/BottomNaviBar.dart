import 'package:Uzaar/screens/beforeLoginScreens/signup_screen.dart';
import 'package:Uzaar/utils/Buttons.dart';
import 'package:flutter/services.dart';
import 'package:Uzaar/screens/SellScreens/ProductSellScreens/product_add_screen_one.dart';
import 'package:Uzaar/screens/ListingsScreens/listings.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/SellScreens/ProductSellScreens/product_add_screen_two.dart';
import 'DrawerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/ExploreScreens/explore_screen.dart';
import '../screens/home_screen.dart';
import '../screens/ProfileScreens/profile_screen.dart';
import '../screens/SellScreens/SellScreen.dart';
import 'package:Uzaar/utils/Colors.dart';

import '../screens/messages_screen.dart';
import 'package:Uzaar/screens/notifications_screen.dart';

class BottomNavBar extends StatefulWidget {
  static const String id = 'bottom_navbar';
  bool? loginAsGuest;
  BottomNavBar({super.key, this.loginAsGuest});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  final List _pages = [
    const HomeScreen(),
    const ExploreScreen(),
    const SellScreen(),
    // const ProductAddScreenOne(),
    // const ProductAddScreenTwo(),
    const ListingsScreen(),
    const ProfileScreen(),
  ];

  int _currentIndex = 0;

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  bool get isIos =>
      foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;
  @override
  Widget build(BuildContext context) {
    // if (isIos) {
    //   return CupertinoTabScaffold(
    //       tabBar: CupertinoTabBar(
    //         currentIndex: _currentIndex,
    //         height: 75.h,
    //         iconSize: 30,
    //         backgroundColor: white,
    //         items: [
    //           BottomNavigationBarItem(
    //             icon: SvgPicture.asset('assets/home-grey.svg'),
    //             activeIcon: SvgPicture.asset('assets/home-active.svg'),
    //             label: '',
    //           ),
    //           BottomNavigationBarItem(
    //             icon: SvgPicture.asset('assets/explore-grey.svg'),
    //             activeIcon: SvgPicture.asset('assets/explore-active.svg'),
    //             label: '',
    //           ),
    //           BottomNavigationBarItem(
    //             icon: SvgPicture.asset('assets/add_item_icon.svg'),
    //             activeIcon: SvgPicture.asset('assets/add_item_selected.svg'),
    //             label: '',
    //           ),
    //           BottomNavigationBarItem(
    //             icon: SvgPicture.asset('assets/list_item_icon.svg'),
    //             activeIcon: SvgPicture.asset('assets/list_item_selected.svg'),
    //             label: '',
    //           ),
    //           BottomNavigationBarItem(
    //             icon: SvgPicture.asset('assets/person-grey.svg'),
    //             activeIcon: SvgPicture.asset('assets/profile-active.svg'),
    //             label: '',
    //           ),
    //         ],
    //         onTap: onTap,
    //       ),
    //       tabBuilder: (context, index) {
    //         return CupertinoTabView(
    //           builder: (context) {
    //             return _pages[_currentIndex];
    //           },
    //         );
    //       });
    // } else {
    // return WillPopScope(
    //   onWillPop: () async {
    //     if (_currentIndex == 0) {
    //       return true;
    //     } else {
    //       setState(() {
    //         _currentIndex = 0;
    //       });
    //     }
    //     return false;
    //   },
    // child:
    return Scaffold(
      key: key,
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
                  // Column(
                  //   children: [
                  //     Text(
                  //       'Good Morning!',
                  //       style: kAppBarTitleStyle,
                  //     ),
                  //     Text(
                  //       'John',
                  //       style: kAppBarTitleStyle,
                  //     ),
                  //   ],
                  // ),
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
          title: _currentIndex == 0
              ? Text(
                  'Home',
                  style: kAppBarTitleStyle,
                )
              : _currentIndex == 1
                  ? Text(
                      'Explore',
                      style: kAppBarTitleStyle,
                    )
                  : _currentIndex == 2
                      ? Text(
                          'Sell',
                          style: kAppBarTitleStyle,
                        )
                      : _currentIndex == 3
                          ? Text(
                              'Listings',
                              style: kAppBarTitleStyle,
                            )
                          : Text(
                              'Profile',
                              style: kAppBarTitleStyle,
                            )),
      drawer: DrawerWidget(
        buildContext: context,
      ),
      body: _currentIndex > 1 && widget.loginAsGuest == true
          ? AlertDialog(
              titleTextStyle: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: primaryBlue),
              elevation: 3,
              contentTextStyle: GoogleFonts.outfit(
                  fontWeight: FontWeight.w400, fontSize: 14, color: grey),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text(
                'Can not Complete Action',
                textAlign: TextAlign.center,
              ),
              content: Text(
                'You can not sell anything on platform in guest mode. Signup now if you want to list any item.',
                textAlign: TextAlign.center,
              ),
              actions: [
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 14.0, left: 8, right: 8),
                  child: primaryButton(
                    context,
                    'Signup',
                    () => Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    )),
                  ),
                )
              ],
            )
          : _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.14),
              blurRadius: 4.0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
            landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
            mouseCursor: MouseCursor.defer,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/home-grey.svg'),
                activeIcon: SvgPicture.asset('assets/home-active.svg'),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/explore-grey.svg'),
                activeIcon: SvgPicture.asset('assets/explore-active.svg'),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/add_item_icon.svg'),
                activeIcon: SvgPicture.asset('assets/add_item_selected.svg'),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/list_item_icon.svg'),
                activeIcon: SvgPicture.asset('assets/list_item_selected.svg'),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/person-grey.svg'),
                activeIcon: SvgPicture.asset('assets/profile-active.svg'),
                label: '',
              ),
            ],
            currentIndex: _currentIndex,
            onTap: onTap,
            type: BottomNavigationBarType.fixed,
            backgroundColor: white,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            iconSize: 30.sp,
          ),
          // Apply box shadow to the ClipRRect
        ),
      ),

      // ),
    );
    // }
  }
}
