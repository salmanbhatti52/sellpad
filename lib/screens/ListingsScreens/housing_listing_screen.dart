import 'package:Uzaar/widgets/housing_list_tile.dart';
import 'package:flutter/material.dart';

import '../../utils/reusable_data.dart';

class HousingListingScreen extends StatefulWidget {
  const HousingListingScreen({Key? key}) : super(key: key);

  @override
  State<HousingListingScreen> createState() => _HousingListingScreenState();
}

class _HousingListingScreenState extends State<HousingListingScreen> {
  dynamic selectedOption;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return HousingListTile(
            houseImage: 'assets/listed_house_img.png',
            houseName: '2 bedroom house',
            houseLocation: 'Los Angeles',
            housePrice: '\$1200',
            houseArea: '4500',
            houseType: 'Rental',
            noOfBaths: '2',
            noOfBeds: '2',
            onSelected: (selectedValue) {
              setState(() {
                selectedOption = selectedValue;
              });
            },
            itemBuilder: (context) {
              return popupMenuOptions;
            },
            initialValue: selectedOption,
          );
        },
        itemCount: 10,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
      ),
    );
  }
}
