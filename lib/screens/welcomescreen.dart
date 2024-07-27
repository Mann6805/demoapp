// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:demoapp/screens/customerloginscreen.dart';
import 'package:demoapp/screens/vendorloginscreen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final double _deviceWidth = MediaQuery.of(context).size.width;
    final double _deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 100,
            ),
            const Text(
              "Are you customer or vendor?",
              style: TextStyle(
                fontSize: 25,
                color: Color(0xFF393333)
              ),
            ),
            Image(
              image: const AssetImage(
                "assets/images/vendor.png"
                ),
                width: _deviceWidth/1.3,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context){
                      return const VendorLoginScreen();
                    }
                  )
                );
              }, 
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                fixedSize: Size(_deviceWidth/3, _deviceHeight/20),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  side: BorderSide(
                    color: Color(0xFF693907)
                  )
                ),
              ),
              child: const Text(
                "Vendor",
                style: TextStyle(
                  color: Color(0xFF693907),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Image(
              image: const AssetImage(
                "assets/images/customer.png"
                ),
                width: _deviceWidth/1.3,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context){
                      return const CustomerLoginScreen();
                    }
                  )
                );
              }, 
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                fixedSize: Size(_deviceWidth/3, _deviceHeight/20),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  side: BorderSide(
                    color: Color(0xFF693907)
                  )
                ),
              ),
              child: const Text(
                "Customer",
                style: TextStyle(
                  color: Color(0xFF693907)
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}