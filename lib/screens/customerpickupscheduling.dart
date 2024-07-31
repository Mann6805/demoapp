import 'dart:io';

import 'package:demoapp/screens/pickupconfirmation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerPickupScheduling extends StatefulWidget {
  var date = "";
  bool isdone = false;
  String customerid;
  String weight;
  String description;
  File photo;
  CustomerPickupScheduling({super.key, required this.customerid, required this.weight, required this.description, required this.photo});

  @override
  State<CustomerPickupScheduling> createState() =>
      _CustomerPickupSchedulingState();
}

class _CustomerPickupSchedulingState extends State<CustomerPickupScheduling> {
  void _showDateDialog() {
    setState(() {
      widget.isdone = true;
    });
    DateTime now = DateTime.now();
    List<DateTime> availableDates = [
      now,
      now.add(Duration(days: 1)),
      now.add(Duration(days: 2)),
    ];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text('Select slot time'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: availableDates.map((date) {
              String formattedDate = DateFormat('dd MMMM, yyyy').format(date);
              return ListTile(
                title: Text(formattedDate),
                subtitle: Text('${date.hour + 1} am - 7 pm'),
                onTap: () {
                  print("Selected Date: $formattedDate");
                  setState(() {
                    widget.date = formattedDate;
                  });
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

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
                SizedBox(
                  width: 3,
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
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  "Schedule Pickup",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  "Confirm",
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Please Provide the below scrap pickup",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: _showDateDialog, 
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.brown,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 110.0, vertical: 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget.isdone?
                      Text(
                        widget.date,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 15),
                      )
                      : const Text(
                        'Same day pickup',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 15),
                      ),
                      const SizedBox(width: 10.0),
                      const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.brown,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30, right: 60, left: 60),
              child: Text(
                "Pickup time between 8 am - 7 pm, Our pickup executive will call you before coming.",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 300,
            ),
            ElevatedButton(
                onPressed: () {
                  if (widget.isdone && widget.date.length != 0){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context){
                          return Pickupconfirmation();
                        }
                      )
                    );
                  }
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFF693907),
                  fixedSize: Size(320, 15),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
