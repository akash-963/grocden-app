import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/order_model.dart';
import '../pages/order_details_page.dart';
import '../widgets/tiles/order_tile.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({super.key});

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  List<MyOrder> ongoingOrders = [];
  List<MyOrder> previousOrders = [];

  // Inside _OrdersTabState
  void getOrdersDetails() async {
    try {
      List<String> orderIds = await fetchOrderIdsForUser();
      List<MyOrder> orders = await fetchOrdersDetails(orderIds);

      // Now you can use the 'orders' list as needed
      setState(() {
        ongoingOrders = orders.where((order) => order.status == "ongoing").toList();
        previousOrders = orders.where((order) => order.status == "previous").toList();
      });
    } catch (e) {
      print('Error fetching orders: $e');
    }
  }



  // Fetch order IDs from user collection
  Future<List<String>> fetchOrderIdsForUser() async {
    try {
      QuerySnapshot ordersSnapshot = await FirebaseFirestore.instance
          .collection('shopCollection')
          .doc(userId)
          .collection('orders')
          .get();

      if (ordersSnapshot.docs.isNotEmpty) {
        List<String> orderIds = ordersSnapshot.docs.map((doc) => doc.id).toList();
        print(orderIds);
        return orderIds;
      }

      return [];
    } catch (e) {
      print('Error fetching order IDs: $e');
      return [];
    }
  }



  // Fetch details for each order from orders collection
  Future<List<MyOrder>> fetchOrdersDetails(List<String> orderIds) async {
    List<MyOrder> orders = [];

    for (String orderId in orderIds) {
      try {
        DocumentSnapshot orderSnapshot = await FirebaseFirestore.instance
            .collection('ordersCollection')
            .doc(orderId)
            .get();

        if (orderSnapshot.exists) {
          List<ProductOrderDetails> products = await fetchProductsForOrder(orderId);

          MyOrder order = MyOrder(
            id: orderId,
            shop: orderSnapshot['shop'],
            buyer: orderSnapshot['buyer'],
            totalValue: orderSnapshot['totalValue'],
            createdTimestamp: orderSnapshot['createdTimestamp'],
            deliveredTimestamp: orderSnapshot['deliveredTimestamp'],
            cancelledTimestamp: orderSnapshot['cancelledTimestamp'],
            tag: orderSnapshot['tag'],
            status: orderSnapshot['status'],
            products: products,
          );

          orders.add(order);
        }
      } catch (e) {
        print('Error fetching order details: $e');
      }
    }

    print(orders);
    return orders;
  }

  Future<List<ProductOrderDetails>> fetchProductsForOrder(String orderId) async {
    try {
      QuerySnapshot productSnapshot = await FirebaseFirestore.instance
          .collection('ordersCollection') // Assuming the products collection is under the ordersCollection
          .doc(orderId)
          .collection('products')
          .get();

      return productSnapshot.docs.map((productDoc) {
        return ProductOrderDetails(
          productId: productDoc.id,
          productName: productDoc['productName'],
          quantity: productDoc['quantity'],
          price: productDoc['price'],
        );
      }).toList();
    } catch (e) {
      print('Error fetching products for order: $e');
      return [];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrdersDetails();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: "Ongoing"),
                Tab(text: "Previous"),
              ],
            ),
            title: const Text('Orders'),

          ),
          body: TabBarView(
            children: [
              OrderList(orders: ongoingOrders),
              Container(child: SingleChildScrollView(child: OrderList(orders: previousOrders))),
            ],
          ),
        )
    );
  }
}


class OrderList extends StatelessWidget {
  final List<MyOrder> orders;

  OrderList({required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailsPage(order: order),
            ),
          ),
          child: OrderTile(order: order),
        );
      },
    );
  }
}


// class OrderDetailsPage extends StatelessWidget {
//   final MyOrder order;
//   const OrderDetailsPage({super.key, required this.order});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }


// class OrderTile extends StatelessWidget {
//   final MyOrder order;
//
//   const OrderTile({Key? key, required this.order}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(8.0),
//       child: ListTile(
//         title: Text('Order ID: '),
//         //${order.orderId}'),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Shop: ${order.shop}'),
//             Text('Buyer: ${order.buyer}'),
//             Text('Total Value: ${order.totalValue}'),
//             Text('Status: ${order.status}'),
//             Text('Created Date: ${order.createdTimestamp.toDate()}'),
//             if (order.deliveredTimestamp != null)
//               Text('Delivered Date: ${order.deliveredTimestamp!.toDate()}'),
//             if (order.cancelledTimestamp != null)
//               Text('Cancelled Date: ${order.cancelledTimestamp!.toDate()}'),
//             // Display other order details as needed
//           ],
//         ),
//         onTap: () {
//           // Handle the tap event, e.g., navigate to a detailed order view
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => OrderDetailsPage(order: order),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }