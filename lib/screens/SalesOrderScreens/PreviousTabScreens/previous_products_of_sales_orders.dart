import 'package:Uzaar/widgets/my_orders_products_list_tile.dart';
import 'package:flutter/material.dart';

import '../../../widgets/add_review_dialog.dart';
import '../../../widgets/get_stars_tile.dart';
import '../../../widgets/message_text_field.dart';

class PreviousProductsOfSalesOrders extends StatefulWidget {
  const PreviousProductsOfSalesOrders({Key? key}) : super(key: key);

  @override
  State<PreviousProductsOfSalesOrders> createState() =>
      _PreviousProductsOfSalesOrdersState();
}

class _PreviousProductsOfSalesOrdersState
    extends State<PreviousProductsOfSalesOrders> {
  final msgTextFieldController = TextEditingController();
  String offerStatus = 'Pending';
  List<String> offerStatuses = ['Pending', 'Accept', 'Reject'];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          // here is use myOrderProductListTile instead of SalesOrderProductListTile because the design is same as MyOrdersProductListTile.
          return GestureDetector(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => SalesOrderDetailScreen(),
              // ));
              showDialog(
                context: context,
                builder: (context) {
                  return AddReviewDialog(
                    content: StarsTile(
                        noOfStars: 5, alignment: MainAxisAlignment.center),
                    title: Image.asset('assets/order_complete.png'),
                    textField: MessageTextField(
                      msgTextFieldController: msgTextFieldController,
                      sendButtonTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              );
            },
            child: MyOrdersProductsListTile(
              productImage: 'uploads/listings_images/17013232441588376617.jpeg',
              productName: 'Iphone 14',
              // productLocation: 'Los Angeles',
              productPrice: '\$12',
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
