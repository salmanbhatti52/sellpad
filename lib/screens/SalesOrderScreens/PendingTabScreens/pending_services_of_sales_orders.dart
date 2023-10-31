import 'package:Uzaar/widgets/my_orders_services_list_tile.dart';
import 'package:Uzaar/widgets/sales_orders_services_list_tile.dart';
import 'package:flutter/material.dart';

class PendingServicesOfSalesOrders extends StatefulWidget {
  const PendingServicesOfSalesOrders({Key? key}) : super(key: key);

  @override
  State<PendingServicesOfSalesOrders> createState() =>
      _PendingServicesOfSalesOrdersState();
}

class _PendingServicesOfSalesOrdersState
    extends State<PendingServicesOfSalesOrders> {
  String offerStatus = 'Pending';
  List<String> offerStatuses = ['Pending', 'Accept', 'Reject'];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return SalesOrdersServicesListTile(
            serviceImage: 'assets/listed_service_img.png',
            serviceName: 'Graphic Design ',
            serviceLocation: 'Los Angeles',
            servicePrice: '\$12',
            date: '08/08/2023',
            onSelected: (selectedOffer) {
              setState(() {
                offerStatus = selectedOffer;
              });
            },
            initialSelection: offerStatus,
            dropdownMenuEntries: offerStatuses
                .map((String value) =>
                    DropdownMenuEntry(value: value, label: value))
                .toList(),
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
