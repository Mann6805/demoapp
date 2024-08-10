import 'dart:io';

import 'package:demoapp/controllers/scrapdetailscontroller.dart';
import 'package:demoapp/server/checker.dart';
import 'package:flutter/material.dart';

class Pickupconfirmation extends StatefulWidget {

  String customerid;
  String weight;
  String description;
  File photo;
  String date;
  String text;
  Pickupconfirmation({super.key, required this.customerid, required this.weight, required this.description, required this.photo, required this.date, required this.text});

  @override
  State<Pickupconfirmation> createState() => _PickupconfirmationState();
}

class _PickupconfirmationState extends State<Pickupconfirmation> {

  
  late double customerlat;
  late double customerlong;
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF693907),
          title: const Text(
            "Sell Scrap",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    width: 20,
                    height: 2,
                    color: const Color.fromARGB(255, 100, 29, 4),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Scrap Details",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 20,
                    height: 2,
                    color: const Color.fromARGB(255, 100, 29, 4),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Schedule Pickup",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 20,
                    height: 2,
                    color: const Color.fromARGB(255, 100, 29, 4),
                  ),
                  const CircleAvatar(
                    backgroundColor: Color(0xFF693907),
                    radius: 7,
                  ),
                  const Text(
                    "Confirm",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              const SizedBox(
                    height: 20,
                  ),
              const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Pickup Confirmation",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                    ),
                  ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Scrap items",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(widget.text),
              const SizedBox(
                height: 3,
              ),
              Text(widget.weight),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Address - Home",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text("33, whitefeild, Bengaluru"),
              const SizedBox(
                height: 10,
              ),
              const Image(
                image: AssetImage("assets/images/customermap.png"),
                width: 1000,
                height: 200,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Pickup (Same day Pickup)",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(widget.date),
              const SizedBox(
                height: 3,
              ),
              const Text(
                "8am - 7pm",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  customerlat = Checker().getlat() as double;
                  customerlong = Checker().getlong() as double;
                  await Scrapdetailscontroller.createProfile(widget.customerid, widget.description, widget.photo, customerlat, customerlong,context);
                  setState(() {
                    isLoading = false;
                  });
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFF693907),
                  fixedSize: Size(320, 15),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                child: isLoading? 
                CircularProgressIndicator(
                  color: Colors.white,
                )
                : const Text(
                  "Confirm",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
            ],
          ),
        ));
  }
}
