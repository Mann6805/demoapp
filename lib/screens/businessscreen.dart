// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:demoapp/screens/welcomescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BusinessScreen extends StatefulWidget {
  const BusinessScreen({super.key});

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  @override
  Widget build(BuildContext context) {

    final double _deviceWidth = MediaQuery.of(context).size.width;
    final double _deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
          children: [
            Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image:  AssetImage("assets/images/signup.png"),
                    fit: BoxFit.cover
                  )
                ),
              ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent,
              ),
              body: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: _deviceHeight,
                    minWidth: _deviceWidth
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Business Detail",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white
                          ),
                        ),
                        const Text(
                          "Please fill the business details",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w200,
                            color: Colors.white
                          ),
                        ),
                        const SizedBox(
                          height: 59.791,
                        ),
                        Container(
                          width: _deviceWidth,
                          height: _deviceHeight/1.429,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(70), topRight: Radius.circular(70))
                          ),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 20, right: 20, top: 80),
                                child: TextField(
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF693907), 
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(15))
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF693907), 
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(15))
                                    ),
                                    prefixIcon: Icon(
                                      Icons.factory,
                                      color: Color(0xFF693907),
                                    ),
                                    labelText: "Business Name",
                                    labelStyle: TextStyle(
                                      color: Color(0XFF9C9898)
                                    )
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
                                child: TextField(
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF693907), 
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(15))
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF693907), 
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(15))
                                    ),
                                    prefixIcon: Icon(
                                      Icons.money,
                                      color: Color(0xFF693907),
                                    ),
                                    labelText: "GST Number (Optional)",
                                    labelStyle: TextStyle(
                                      color: Color(0XFF9C9898)
                                    )
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 20, bottom: 10),
                                  child: Text(
                                    "Upload the following",
                                  ),
                                ),
                              ),
                              Container(
                                width: _deviceWidth/1.12,
                                height: _deviceHeight/15,
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xFF693907)),
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                child: const Row (
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "PAN card"
                                    ),
                                    SizedBox(
                                      width: 170,
                                    ),
                                    Icon(
                                      Icons.upload_rounded,
                                      color: Color(0xFF693907),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Upload",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w200
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: _deviceWidth/1.12,
                                height: _deviceHeight/15,
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xFF693907)),
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                child: const Row (
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "Business Picture"
                                    ),
                                    SizedBox(
                                      width: 120,
                                    ),
                                    Icon(
                                      Icons.upload_rounded,
                                      color: Color(0xFF693907),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Upload",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w200
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context){
                                          return const WelcomeScreen();
                                        }
                                      ),
                                      (route){
                                        return false;
                                      }
                                    );
                                  }, 
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: const Color(0XFF9C9898),
                                    fixedSize: Size(_deviceWidth, _deviceHeight/15),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                    ),
                                  ),
                                  child: const Text(
                                    "Continue",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    ),
                                  )
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
  }
}