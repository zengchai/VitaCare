import 'package:flutter/material.dart';
import 'package:shopwiz/pages/order/order_detail.dart';
import 'package:shopwiz/pages/order/review_widget.dart';
import 'package:shopwiz/services/auth.dart';
import 'package:shopwiz/services/database.dart';
import 'package:shopwiz/shared/image.dart';

class Order_card extends StatefulWidget {
  final String orderId;
  final double totalPrice;
  final int totalQuantity;
  final String status;
  final List<Map<String, dynamic>> store;

  const Order_card({
    Key? key,
    required this.orderId,
    required this.totalPrice,
    required this.totalQuantity,
    required this.status,
    required this.store,
  }) : super(key: key);

  @override
  State<Order_card> createState() => _Order_cardState();
}

class _Order_cardState extends State<Order_card> {
  final AuthService _auth = AuthService();
  late Map<String, dynamic> userData = {};
  Future<void> orderDetail(
      String orderId, List<Map<String, dynamic>> store) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDetailScreen(orderId: orderId, store: store),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(20, 25, 20, 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      shadowColor: Colors.grey.withOpacity(0.0),
      child: Container(
        height: 150,
        padding: EdgeInsets.fromLTRB(23, 15, 23, 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey
                  .withOpacity(0.3), // Set the shadow color and opacity
              spreadRadius: 5, // Spread radius
              blurRadius: 10, // Blur radius
              offset: Offset(0, 0), // Offset in x and y direction
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProductImageWidget(
                  productId: widget.store.first['items'].first['productId']),
              SizedBox(width: 25),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        child: Text(
                      widget.store.first['items'].first['productName'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Opacity(
                                opacity: 0.7,
                                child: Text(
                                  "Qty: ${widget.totalQuantity}",
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.fromLTRB(9, 3, 9, 3),
                                child: Opacity(
                                  opacity: 0.7,
                                  child: Text(
                                    widget.status,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Opacity(
                                opacity: 0.7,
                                child: Text(
                                  widget.orderId,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  orderDetail(widget.orderId, widget.store);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2,
                                      horizontal:
                                          15), // Adjust padding as needed
                                  backgroundColor: Color.fromARGB(
                                    255,
                                    108,
                                    74,
                                    255,
                                  ),
                                ),
                                child: Text(
                                  'Review',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: 4),
                              Opacity(
                                opacity: 0.7,
                                child: Text(
                                  "RM ${widget.totalPrice}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}