import 'dart:convert';

import 'package:demoapp/controllers/notificationcontroller.dart';
import 'package:demoapp/screens/lead.dart';
import 'package:demoapp/screens/routemap.dart';
import 'package:demoapp/server/checker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:getwidget/getwidget.dart';
import 'dart:async';

class VendorHomeScreen extends StatefulWidget {
  String vendorid;
  VendorHomeScreen({super.key, required this.vendorid});

  @override
  State<VendorHomeScreen> createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen> {
  bool leads = true;
  bool online = false;
  List<Map<String, dynamic>> pickupRequests = [];
  Timer? _timer;
  StreamSubscription<Position>? positionStream;
  double? lat;
  double? long;
  late DateTime scheduleTime;

  @override
  void initState() {
    super.initState();
    _startPolling(online);
    NotificationServices.scheduleNotification(message: "Please check this route.");
  }
  void startTrackingLocation() {
    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, 
      ),
    ).listen((Position position) {
      setState(() {
        lat = position.latitude;
        long = position.longitude;
      });
    });
  }

  void stopTrackingLocation() {
    positionStream?.cancel();
  }

  void _stopPolling() {
    _timer?.cancel();
    _timer = null;
  }

  void _startPolling(bool online) async {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      if (online) {
        if (positionStream == null) {
          startTrackingLocation(); // Start tracking if not already tracking
        }
        print("Sending location to server: $lat, $long");

        // Send location data to the server
        Checker().vsetLocation(lat!, long!);
        Map<String, dynamic> data = {
          "vendor_id": widget.vendorid,
          "latitude": lat.toString(),
          "longitude": long.toString(),
        };
        final url = Uri.parse(
            "https://trashandler-api-s-1-259j.onrender.com/vend_location/");
        final response = await http.post(url, body: data);
        if (response.statusCode == 201) {
          print(response.body);
        } else {
          print(response.body);
        }
      } else {
        stopTrackingLocation();
      }
      fetchPickupRequests().then((requests) {
        setState(() {
          pickupRequests = requests;
        });
      }).catchError((error) {
        print('Failed to load pickup requests: $error');
      });
    });
  }

  Future<List<Map<String, dynamic>>> fetchPickupRequests() async {
    final url = Uri.parse(
        'https://trashandler-api-s-1-259j.onrender.com/vendor/pickup-requests/${widget.vendorid}/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load pickup requests');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image(
              image: const AssetImage("assets/images/logo.png"),
              width: _deviceWidth / 3,
            ),
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
          backgroundColor: const Color(0XFF693907),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ), 
            ElevatedButton(onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context){
                  return const Routemap();
                })
              );
            }, child: Icon(Icons.map)),               
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
                        color: leads
                            ? const Color(0XFF693907)
                            : const Color(0XFF9C9898),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12))),
                    width: _deviceWidth / 2.3,
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 10, right: 20, bottom: 10, left: 20),
                        child: Text(
                          "New Leads",
                          style: TextStyle(color: Colors.white, fontSize: 14),
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
                        color: leads
                            ? const Color(0XFF9C9898)
                            : const Color(0XFF693907),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12))),
                    width: _deviceWidth / 2.3,
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 10, right: 20, bottom: 10, left: 20),
                        child: Text(
                          "Accepted Leads",
                          style: TextStyle(color: Colors.white, fontSize: 14),
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
            leads
                ? Padding(
                    padding: const EdgeInsets.only(right: 21, left: 21),
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        border: Border.all(color: const Color(0XFF693907)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(
                              "You are online",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: GFToggle(
                              onChanged: (value) async {
                                Map<String, dynamic> data = {
                                  "vendor_id": widget.vendorid,
                                  "is_active": value!.toString()
                                };
                                final url = Uri.parse(
                                    "https://trashandler-api-s-1-259j.onrender.com/vendor_status/");
                                final response =
                                    await http.post(url, body: data);
                                if (response.statusCode == 201) {
                                  print("Success");
                                } else {
                                  print(response.body);
                                }
                                online = value!;
                                setState(() {});
                                if (online){
                                  _startPolling(online);
                                }
                                else{
                                  _stopPolling();
                                }
                              },
                              value: online,
                              enabledThumbColor: Colors.white,
                              enabledTrackColor: const Color(0XFF48AC38),
                              type: GFToggleType.ios,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 10,
                  ),
            const SizedBox(
              height: 10,
            ),
            online
                ? Expanded(
                    child: ListView.builder(
                      itemCount: pickupRequests.length,
                      itemBuilder: (context, index) {
                        var lead = pickupRequests[index];
                        return Lead(
                            name: lead['customer_name'],
                            description: lead['description'],
                            slot: lead['timeslots'],
                            landmark: lead['landmark'],
                            distance: lead['distance'],
                            photo: lead['photo']);
                      },
                    ),
                  )
                : leads
                    ? Column(
                        children: [
                          Image(
                            image: const AssetImage(
                                "assets/images/vendornewlead.png"),
                            width: _deviceWidth / 1.1,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text("No scrap leads to show !",
                              style: TextStyle(
                                fontSize: 20,
                              )),
                          SizedBox(
                            width: _deviceWidth / 1.6,
                            child: const Text(
                              "More opportunities are on the way! Check back soon for the Leads",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 17),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Image(
                            image: const AssetImage(
                                "assets/images/vendoracceptlead.png"),
                            width: _deviceWidth / 1.1,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text("No accepted leads yet !",
                              style: TextStyle(
                                fontSize: 20,
                              )),
                          SizedBox(
                            width: _deviceWidth / 1.6,
                            child: const Text(
                              "keep the momentum going! New scrap opportunities are waiting. Review the 'New Leads' section to find your next haul",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 17),
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
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on_outlined), label: "Track"),
            BottomNavigationBarItem(
                icon: Icon(Icons.history_outlined), label: "History"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: "Account")
          ],
        ));
  }
}
