import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Uzaar/utils/Colors.dart';

import 'housing_icon_text_widget.dart';

final kCardTagTextStyle = GoogleFonts.outfit(
  fontSize: 10,
  fontWeight: FontWeight.w500,
  color: white,
);
final kNewTagTextStyle = GoogleFonts.outfit(
  fontSize: 10,
  fontWeight: FontWeight.w500,
  color: primaryBlue,
);

final kCardHeadingTextStyle = GoogleFonts.outfit(
  fontSize: 13,
  fontWeight: FontWeight.w500,
  color: black,
);

final kLocationTexStyle = GoogleFonts.outfit(
  fontSize: 10,
  fontWeight: FontWeight.w400,
  color: grey,
);

final kPriceTextStyle = GoogleFonts.outfit(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  color: primaryBlue,
);

class FeaturedHousingWidget extends StatelessWidget {
  final String image;
  final String productCategory;
  final String productDescription;
  final String productLocation;
  final String productPrice;
  const FeaturedHousingWidget(
      {super.key,
      required this.image,
      required this.productCategory,
      required this.productDescription,
      required this.productLocation,
      required this.productPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, top: 2, bottom: 2, left: 1),
      width: 154,
      decoration: kCardBoxDecoration,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                child: Image.asset(
                  image,
                ),
              ),
              Positioned(
                left: 6,
                top: 5,
                child: SvgPicture.asset(
                  'assets/verify-check.svg',
                  width: 20,
                  height: 20,
                ),
              ),
              Positioned(
                right: 3,
                top: 5,
                child: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ),
              Positioned(
                left: 6,
                bottom: 9,
                child: Container(
                  width: 70,
                  height: 24,
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      productCategory,
                      style: kCardTagTextStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 7.0, right: 7.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    productDescription,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                    style: kCardHeadingTextStyle,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/address-icon.svg',
                          width: 14,
                          height: 14,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          productLocation,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: true,
                          style: kLocationTexStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/price-tag.svg',
                          width: 14,
                          height: 14,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text('\$$productPrice', style: kPriceTextStyle),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HousingIconTextWidget(
                      imageName: 'area_icon',
                      text: '4500 sq.mt',
                    ),
                    HousingIconTextWidget(
                      imageName: 'bath_icon',
                      text: '2',
                    ),
                    HousingIconTextWidget(
                      imageName: 'bed_icon',
                      text: '2',
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
