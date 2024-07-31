import 'package:flutter/material.dart';

class Pickupconfirmation extends StatefulWidget {
  const Pickupconfirmation({super.key});

  @override
  State<Pickupconfirmation> createState() => _PickupconfirmationState();
}

class _PickupconfirmationState extends State<Pickupconfirmation> {
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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Please Provide the below scrap pickup",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                    ),
                  ),
                ],
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
              const Text("Paper"),
              const SizedBox(
                height: 3,
              ),
              const Text("1 kg"),
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
                width: 100,
                height: 100,
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
              const Text("07 June 2024"),
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
              const Text(
                "Any Instructions",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 70),
                child: TextFormField(
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF693907),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF693907),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color(0xFF693907),
                      ),
                      labelText: "Name",
                      labelStyle: TextStyle(color: Color(0XFF9C9898))),
                ),
              ),
            ],
          ),
        ));
  }
}
