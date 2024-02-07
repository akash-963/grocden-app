import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../widgets/app_header.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {


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