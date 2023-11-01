import 'package:Uzaar/widgets/my_orders_services_list_tile.dart';
import 'package:Uzaar/widgets/sales_orders_services_list_tile.dart';
import 'package:flutter/material.dart';

import '../sales_order_detail.dart';

class PreviousServicesOfSalesOrders extends StatefulWidget {
  const PreviousServicesOfSalesOrders({Key? key}) : super(key: key);

  @override
  State<PreviousServicesOfSalesOrders> createState() =>
      _PreviousServicesOfSalesOrdersState();
}

class _PreviousServicesOfSalesOrdersState
    extends State<PreviousServicesOfSalesOrders> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SalesOrderDetailScreen(),
              ));
            },
            child: MyOrdersServicesListTile(
              serviceImage: 'assets/listed_service_img.png',
              serviceName: 'Graphic Design ',
              serviceLocation: 'Los Angeles',
              servicePrice: '\$12',
              date: '08/08/2023',
            ),
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
