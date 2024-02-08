import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../models/order_model.dart';
import '../widgets/app_header.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  int ongoingOrders = 0;
  int previousOrders = 0;

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

          MyOrder order = MyOrder(
            id: orderId,
            totalValue: orderSnapshot['totalValue'],
            status: orderSnapshot['status'],
          );

          orders.add(order);
        }
      } catch (e) {
        print('Error fetching order details: $e');
      }
    }

    // print(orders);
    return orders;
  }

  // Inside _OrdersTabState
  Future<void> getOrdersDetails() async {
    try {
      List<String> orderIds = await fetchOrderIdsForUser();
      List<MyOrder> orders = await fetchOrdersDetails(orderIds);

      // Now you can use the 'orders' list as needed
      setState(() {
        // ongoingOrders = orders.where((order) => order.status == "ongoing").toList();
        // previousOrders = orders.where((order) => order.status == "previous").toList();
        ongoingOrders = orders.where((order) => order.status == "ongoing").length;
        previousOrders = orders.where((order) => order.status == "ongoing").length;
      });
    } catch (e) {
      print('Error fetching orders: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getOrdersDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppHeader(),
                SizedBox(height: 16,),
                "Dashboard".text.xl2.bold.color(Colors.grey).make().p(8),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.height / 10,
                              // width: MediaQuery.of(context).size.width / 2.5,
                              decoration: BoxDecoration(
                                color: Colors.greenAccent,
                              ),
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  "Ongoing Orders".text.xl2.color(Colors.black54).make(),
                                  "${ongoingOrders}".text.xl.make(),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 4), // Add some spacing between items
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.height / 10,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                              ),
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  "Completed Orders".text.xl2.color(Colors.black54).make(),
                                  "23".text.xl.make(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4), // Add some spacing between rows
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.height / 10,
                              decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                              ),
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  "Cancelled Orders".text.xl2.color(Colors.black54).make(),
                                  "23".text.xl.make(),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 4), // Add some spacing between items
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.height / 10,
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                              ),
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  "Total Orders".text.xl2.color(Colors.black54).make(),
                                  "23".text.xl.make(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ]
            ),
          ),
        )
    );

  }
}










// class DashBoardModel {
//   Rx<List<OngoingordersItemModel>> ongoingordersItemList = Rx([
//     OngoingordersItemModel(
//         ongoingOrdersText: "Ongoing Orders".obs, tenText: "10".obs),
//     OngoingordersItemModel(
//         ongoingOrdersText: "Completed Orders".obs, tenText: "57".obs),
//     OngoingordersItemModel(
//         ongoingOrdersText: "Total Orders".obs, tenText: "67".obs),
//     OngoingordersItemModel(
//         ongoingOrdersText: "Total Sales".obs, tenText: "1000".obs)
//   ]);
// }




// class OngoingordersItemModel {
//   OngoingordersItemModel({
//     this.ongoingOrdersText,
//     this.tenText,
//     this.id,
//   }) {
//     ongoingOrdersText = ongoingOrdersText ?? Rx("Ongoing Orders");
//     tenText = tenText ?? Rx("10");
//     id = id ?? Rx("");
//   }
//
//   Rx<String>? ongoingOrdersText;
//
//   Rx<String>? tenText;
//
//   Rx<String>? id;
// }