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

  bool leads = true;
  bool online = true;

  @override
  Widget build(BuildContext context) {

    final double _deviceWidth = MediaQuery.of(context).size.width;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  leads = true;
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: leads ? const Color(0XFF693907) : const Color(0XFF9C9898), 
                    borderRadius: const BorderRadius.all(Radius.circular(12))
                  ),
                  width: _deviceWidth/2.3,
                  
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
                onTap: () {
                  leads = false;
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: leads ? const Color(0XFF9C9898) : const Color(0XFF693907), 
                    borderRadius: const BorderRadius.all(Radius.circular(12))
                  ),
                  width: _deviceWidth/2.3,
                  
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
          const SizedBox(
            height: 15,
          ),
          leads ? Padding(
            padding: const EdgeInsets.only(right: 21,left: 21),
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
                        onChanged: (online) => {online = false},
                        value: true,
                        enabledThumbColor:Colors.white,
                        enabledTrackColor: const Color(0XFF48AC38),
                        type: GFToggleType.ios,
                    ),
                  )
                ],
              ),
            ),
          )
          : const SizedBox( height: 10,),
          const SizedBox(
            height: 50,
          ),
          leads ? Column(
            children: [
              Image(image: const AssetImage("assets/images/vendornewlead.png"), width: _deviceWidth/1.1,),
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
          ): Column(
            children: [
              Image(image: const AssetImage("assets/images/vendoracceptlead.png"), width: _deviceWidth/1.1,),
              const SizedBox(
                height: 20,
              ),
              const Text("No accepted leads yet !", style: TextStyle(fontSize: 20,)),
              SizedBox(
                width: _deviceWidth/1.6,
                child: const Text("keep the momentum going! New scrap opportunities are waiting. Review the 'New Leads' section to find your next haul", 
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
              ),
            ],
          )
          ,
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