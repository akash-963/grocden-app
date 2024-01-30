import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:velocity_x/velocity_x.dart';
import '../models/product_model.dart';
import '../widgets/app_header.dart';
import '../widgets/lists/product_list.dart';

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
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height:100,
                        width: 100,
                        color: Colors.blue,
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        color: Colors.green,
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ),
        )
    );

  }
}
