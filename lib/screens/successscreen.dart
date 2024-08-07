// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:ui';

import 'package:demoapp/screens/customerhome.dart';
import 'package:demoapp/screens/simplemap.dart';
import 'package:demoapp/screens/vendorhomescreen.dart';
import 'package:demoapp/server/checker.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {

  final bool iscustomer;
  String customerid;
  String vendorid;
  SuccessScreen({super.key, required this.iscustomer, required this.customerid, required this.vendorid});

  @override
  Widget build(BuildContext context) {

    final double _deviceWidth = MediaQuery.of(context).size.width;

    Future.delayed(const Duration(seconds: 3), () {
      print("Customer : ${iscustomer}, Customerid : ${customerid}, Vendorid : ${vendorid}");
      Checker().setCustomerStatus(iscustomer, customerid, vendorid);
      Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(
          builder: (context) {
            return LocationScreen(customerid: customerid, vendorid: vendorid, iscustomer: iscustomer); 
          }
        ), 
        (route) {
          return false;
        }
      );
    });

    return Scaffold(
      backgroundColor: const Color(0xFF693907),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Container(
                width: _deviceWidth,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0XFF9B642B),Color(0XFF492A0A)]
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 35, sigmaY: 15),
                    child: const Image(
                      image: AssetImage("assets/images/success.png"),
                    ),
                  ),
                ),
              ),
            ),
            const CircleAvatar(
              backgroundColor: Color(0XFF48AC38),
              child: Icon(
                  Icons.done,
                  size: 40.0,
                  color: Color(0xFF693907),
                )
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Login verified !",
              style: TextStyle(
                color: Colors.white,
                fontSize: 23
              ),
            )
          ],
        ),
      ),
    );
  }
}