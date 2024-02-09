import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/order_model.dart';

class OrderDetailsPage extends StatefulWidget {
  final MyOrder order;

  const OrderDetailsPage({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {

  Future<void> _statusUpdate(String orderId) async {
    try {
      // Store the order details in Firestore
      await FirebaseFirestore.instance
          .collection('ordersCollection')
          .doc(orderId)
          .update({
        'status': "delivered",
      });
      print('Order status updated successfully to delivered.');
      setState(() {

      });
    } catch (e) {
      print('Error updating order status: $e');
      // Optionally, you can rethrow the error or handle it differently
    }
  }

  @override
  Widget build(BuildContext context) {
    // getShopName();
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Order ID: ${widget.order.id}'),
            if (widget.order.createdTimestamp != null)
              Text('Created Date: ${widget.order.createdTimestamp!.toDate()}'),
            if (widget.order.deliveredTimestamp != null)
              Text('Delivered Date: ${widget.order.deliveredTimestamp!.toDate()}'),
            if (widget.order.cancelledTimestamp != null)
              Text('Cancelled Date: ${widget.order.cancelledTimestamp!.toDate()}'),

            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Value: \₹${widget.order.totalValue}'),
                  Text('Status: ${widget.order.status}'),
                ]
            ),
            SizedBox(height: 16),
            Text(
              'Ordered Products:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if(widget.order.products != null)
              for (ProductOrderDetails orderDetails in widget.order.products!)
                ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${orderDetails.productName.length > 20 ? orderDetails.productName.substring(0, 20) + '...' : orderDetails.productName}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text('\₹${orderDetails.price}'),
                    ],
                  ),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Product: ${orderDetails.productName}'),
                        Text('Quantity: ${orderDetails.quantity}'),
                        Text('Price: \₹${orderDetails.price}'),
                      ],
                    ),
                  ],
                ),
            Spacer(),
            if(widget.order.status == "ongoing")
              Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: (){
                        _statusUpdate(widget.order.id);
                        setState(() {
                          widget.order.status = "delivered";
                        });
                    },
                    child: Text("Mark as Completed"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}