import 'package:Uzaar/widgets/my_orders_housings_list_tile.dart';
import 'package:flutter/material.dart';

class PreviousHousingsOfSalesOrders extends StatefulWidget {
  const PreviousHousingsOfSalesOrders({Key? key}) : super(key: key);

  @override
  State<PreviousHousingsOfSalesOrders> createState() =>
      _PreviousHousingsOfSalesOrdersState();
}

class _PreviousHousingsOfSalesOrdersState
    extends State<PreviousHousingsOfSalesOrders> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return MyOrdersHousingsListTile(
            houseImage: 'assets/listed_house_img.png',
            houseName: '2 bedroom house ',
            houseLocation: 'Los Angeles',
            housePrice: '\$1200',
            houseArea: '4500',
            houseType: 'Rental',
            noOfBaths: '2',
            noOfBeds: '2',
            date: '08/08/2023',
            offeredPrice: '\$1200',
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
