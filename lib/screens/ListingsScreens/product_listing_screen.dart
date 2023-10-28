import 'package:Uzaar/utils/Buttons.dart';
import 'package:Uzaar/widgets/alert_dialog_reusable.dart';
import 'package:flutter/material.dart';

import '../../utils/reusable_data.dart';
import '../../widgets/product_list_tile.dart';

enum BoostingPackages { pkg1, pkg2, pkg3, pkg4 }

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({Key? key}) : super(key: key);

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  BoostingPackages? _selectedPackage = BoostingPackages.pkg1;
  dynamic selectedOption;
  updateSelectedPackage(value) {
    _selectedPackage = value;
    print(_selectedPackage);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ProductListTile(
            productImage: 'assets/listed_pro_img.png',
            productName: 'Iphone 14',
            productLocation: 'Los Angeles',
            productPrice: '\$12',
            onSelected: (selectedValue) {
              setState(() {
                selectedOption = selectedValue;
                print(selectedOption);
                if (selectedOption == 'boost') {
                  showDialog(
                    context: context,
                    builder: (
                      context,
                    ) {
                      return StatefulBuilder(
                        builder: (BuildContext context,
                                StateSetter stateSetterObject) =>
                            AlertDialogReusable(
                          description: 'Boost your listings to get more orders',
                          title: 'Boost Listings',
                          itemsList: [
                            ListTile(
                              title: Text('\$1 Per Day for 1 Item'),
                              leading: Radio(
                                value: BoostingPackages.pkg1,
                                groupValue: _selectedPackage,
                                onChanged: (value) {
                                  stateSetterObject(() {
                                    updateSelectedPackage(value);
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: Text('\$5 Per Week for 1 Item'),
                              leading: Radio(
                                value: BoostingPackages.pkg2,
                                groupValue: _selectedPackage,
                                onChanged: (value) {
                                  stateSetterObject(() {
                                    updateSelectedPackage(value);
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: Text('\$10 Per Month for 1 Item'),
                              leading: Radio(
                                value: BoostingPackages.pkg3,
                                groupValue: _selectedPackage,
                                onChanged: (value) {
                                  stateSetterObject(() {
                                    updateSelectedPackage(value);
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: Text('\$20 Per Month for Unlimited Items'),
                              leading: Radio(
                                value: BoostingPackages.pkg4,
                                groupValue: _selectedPackage,
                                onChanged: (value) {
                                  stateSetterObject(() {
                                    updateSelectedPackage(value);
                                  });
                                },
                              ),
                            ),
                          ],
                          button: primaryButton(context, 'Boost Now',
                              () => Navigator.of(context).pop()),
                        ),
                      );
                    },
                  );
                }
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
