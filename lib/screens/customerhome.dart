import 'package:demoapp/screens/custombutton.dart';
import 'package:demoapp/screens/customerscrapdetails.dart';
import 'package:flutter/material.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({super.key});

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  List<bool> isSelected = [false, false, false, false];
  @override
  Widget build(BuildContext context) {
    Color color(int index) => isSelected[index]
        ? const Color.fromARGB(255, 246, 200, 150)
        : Colors.white;
    final _size = MediaQuery.of(context).size;
    bool isselected = false;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Column(
          children: [
            Text(
              "Pickup Location - Home",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12),
            ),
            Text(
              "M-404 Sumruddh Greens, Vastral",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 15),
            ),
          ],
        )),
        backgroundColor: const Color(0xff693907),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      ),
      body: Stack(
        children: [
          Transform.translate(
            offset: const Offset(0, -70),
            child: const Opacity(
              opacity: 0.5,
              child: Image(
                image: AssetImage(
                  "assets/images/image.png",
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Good evening, Parth",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 60,
                    right: 60,
                  ),
                  child: Text(
                    "What would you like to sell?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isselected = !isselected;
                          isSelected[0] = !isSelected[0];
                        });
                      },
                      child: Custombutton(
                        categoryname: "Paper",
                        itemname: "Newspapers, cartons, books",
                        itemimage: const AssetImage("assets/images/paper.png"),
                        selcolor: color(0),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isselected = !isselected;
                          isSelected[1] = !isSelected[1];
                        });
                      },
                      child: Custombutton(
                        categoryname: "Plastic",
                        itemname: "Oil container, hard/soft plastic",
                        itemimage:
                            const AssetImage("assets/images/plastic.png"),
                        selcolor: color(1),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isselected = !isselected;
                          isSelected[2] = !isSelected[2];
                        });
                      },
                      child: Custombutton(
                        categoryname: "Metals",
                        itemname: "Utensils, coolers, drums etc.",
                        itemimage: const AssetImage("assets/images/metal.png"),
                        selcolor: color(2),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isselected = !isselected;
                          isSelected[3] = !isSelected[3];
                        });
                      },
                      child: Custombutton(
                        categoryname: "Others",
                        itemname: "Beer bottles, machines, etc.",
                        itemimage: const AssetImage("assets/images/fridge.png"),
                        selcolor: color(3),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 150,
                ),
                const Center(
                  child: Text("We do not accept \"WET Waste\""),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const CustomerScrapDetails();
                      }));
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: isSelected.contains(true)
                          ? const Color(0xFF693907)
                          : Colors.grey,
                      fixedSize: Size(_size.width / 1.2, _size.height / 15),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    child: const Text(
                      "Raise Pickup Request",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
