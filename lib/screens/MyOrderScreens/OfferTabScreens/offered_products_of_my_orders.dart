import 'package:Uzaar/widgets/my_orders_products_list_tile.dart';
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

import '../my_order_detail.dart';

class OfferedProductsOfMyOrders extends StatefulWidget {
  const OfferedProductsOfMyOrders(
      {Key? key,
      required this.myOrderedProductOffers,
      required this.orderedProductOffersErrMsg})
      : super(key: key);
  final List<dynamic> myOrderedProductOffers;
  final String orderedProductOffersErrMsg;
  @override
  State<OfferedProductsOfMyOrders> createState() =>
      _OfferedProductsOfMyOrdersState();
}

class _OfferedProductsOfMyOrdersState extends State<OfferedProductsOfMyOrders> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: widget.myOrderedProductOffers.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyOrderDetailScreen(),
                    ));
                  },
                  child: MyOrdersProductsListTile(
                    productImage: widget.myOrderedProductOffers[index]
                        ['listings_products']['listings_images'][0]['image'],
                    productName: widget.myOrderedProductOffers[index]
                        ['listings_products']['name'],
                    // productLocation: 'Los Angeles',
                    productPrice:
                        '\$${widget.myOrderedProductOffers[index]['listings_products']['price']}',
                    date: widget.myOrderedProductOffers[index]['status'] ==
                            'Pending'
                        ? widget.myOrderedProductOffers[index]['date_added']
                        : widget.myOrderedProductOffers[index]['date_modified'],
                    offeredPrice:
                        '\$${widget.myOrderedProductOffers[index]['offer_price']}',
                    allowPay: widget.myOrderedProductOffers[index]['status'] ==
                            'Accepted'
                        ? true
                        : false,
                    offerStatus: widget.myOrderedProductOffers[index]['status'],
                  ),
                );
              },
              itemCount: widget.myOrderedProductOffers.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
            )
          : widget.myOrderedProductOffers.isEmpty &&
                  widget.orderedProductOffersErrMsg == ''
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                        child: Column(
                          children: [
                            Container(
                                // margin: EdgeInsets.only(bottom: 15),
                                child: MyOrdersProductsListTileDummy()),
                          ],
                        ),
                        baseColor: Colors.grey[500]!,
                        highlightColor: Colors.grey[100]!);
                  },
                  itemCount: 5,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                )
              : widget.myOrderedProductOffers.isEmpty &&
                      widget.orderedProductOffersErrMsg != ''
                  ? Center(
                      child: Text(widget.orderedProductOffersErrMsg),
                    )
                  : SizedBox(),
    );
  }
}
