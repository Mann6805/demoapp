import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/getwidget.dart';

class VendorHomeScreen extends StatefulWidget {
  const VendorHomeScreen({super.key});

  @override
  State<VendorHomeScreen> createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen> {
  @override
  Widget build(BuildContext context) {

    final double _deviceWidth = MediaQuery.of(context).size.width;
    final double _deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image(image: const AssetImage("assets/images/logo.png"), width: _deviceWidth/3,),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25)
          )
        ),
        backgroundColor: const Color(0XFF693907),
        
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15,left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () => (),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0XFF693907), 
                      borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
                    width: _deviceWidth/2.5,
                    
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, right: 20, bottom: 10, left: 20),
                        child: 
                          Text("New Leads",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14
                            ),
                          ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => (),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0XFF9C9898), 
                      borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
                    width: _deviceWidth/2.5,
                    
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, right: 20, bottom: 10, left: 20),
                        child: 
                          Text("Accepted Leads",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14
                            ),
                          ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 33,left: 33),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(
                  color: const Color(0XFF693907)
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "You are online", 
                      style: TextStyle(
                        fontSize: 15
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: GFToggle(
                        onChanged: (val) => {},
                        value: true,
                        enabledThumbColor:Colors.white,
                        enabledTrackColor: const Color(0XFF48AC38),
                        type: GFToggleType.ios,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Column(
            children: [
              Image(image: const AssetImage("assets/images/vendorhome.png"), width: _deviceWidth/1.1,),
              const SizedBox(
                height: 20,
              ),
              const Text("No scrap leads to show !", style: TextStyle(fontSize: 20,)),
              SizedBox(
                width: _deviceWidth/1.6,
                child: const Text("More opportunities are on the way! Check back soon for the Leads", 
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0XFF693907),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: "Track"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            label: "History"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Account"
          )
        ],
      )
    );
  }
}