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
                "Dashboard".text.xl2.bold.color(Colors.green).make().p(8),
                Container(
                    height: MediaQuery.of(context).size.height / 5,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(width: 2),
                      // color: Colors.deepPurpleAccent,
                    ),
                    // child: GridView.count(
                    //   shrinkWrap: true,
                    //   crossAxisCount: 2,
                    //
                    //   itemCount: 5,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return Container(
                    //       child: Column(
                    //         children: [
                    //           "Ongoing Orders".text.make(),
                    //           "10".text.make(),
                    //         ],
                    //       ),
                    //     );
                    //   },
                    //
                    // ),
                  ),
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