import 'dart:convert';

import 'package:demoapp/screens/customerhome.dart';
import 'package:demoapp/screens/vendorhomescreen.dart';
import 'package:demoapp/server/checker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class LocationScreen extends StatefulWidget {

  String customerid;
  String vendorid;
  bool iscustomer;
  LocationScreen({super.key, required this.customerid, required this.vendorid, required this.iscustomer});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  LatLng? _currentPosition;
  LatLng? _selectedPosition;
  late GoogleMapController _mapController;
  final TextEditingController _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, request users to enable them.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Permissions are granted, get the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _selectedPosition = _currentPosition;
    });

    // Move the map camera to the current location.
    if (_mapController != null) {
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _currentPosition!,
            zoom: 14.0,
          ),
        ),
      );
    }
  }

  void _onMapTapped(LatLng position) {
    setState(() {
      _selectedPosition = position;
    });
  }

  void _goToCurrentLocation() {
  if (_currentPosition != null) {
    setState(() {
      _selectedPosition = _currentPosition; // Update the marker position
    });

    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _currentPosition!,
          zoom: 14.0,
        ),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _currentPosition == null
              ? Center(child: CircularProgressIndicator())
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition ?? LatLng(0, 0),
                    zoom: 14.0,
                  ),
                  onMapCreated: (controller) {
                    _mapController = controller;
                    // Move the map camera to the current location once the map is created.
                    if (_currentPosition != null) {
                      _mapController.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: _currentPosition!,
                            zoom: 14.0,
                          ),
                        ),
                      );
                    }
                  },
                  onTap: _onMapTapped,
                  markers: _selectedPosition != null
                      ? {
                          Marker(
                            markerId: MarkerId('selected-location'),
                            position: _selectedPosition!,
                          ),
                        }
                      : {},
                ),
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                          labelText: "Enter your address",
                          fillColor: Colors.white, 
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF693907), 
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF693907), 
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_selectedPosition != null)
            Positioned(
              bottom: 80,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: 
                    () async {
                      if (widget.iscustomer && _selectedPosition != null && _addressController.text.isNotEmpty){

                        Checker checker = Checker();
                        checker.setAddress(_addressController.text);

                        final url = Uri.parse("https://trashandler-api-s-1-259j.onrender.com/cust_location/");
                        final addressList = [
                            {
                              "street": _addressController.text,
                              "city": _addressController.text,
                              "state": _addressController.text,
                              "zip_code": "1234567890",
                              "latitude": _selectedPosition?.latitude,
                              "longitude": _selectedPosition?.longitude,
                            },
                          ];

                          final response = await http.post(
                            url,
                            headers: <String, String>{
                              'Content-Type': 'application/json',
                            },
                            body: jsonEncode(<String, dynamic>{
                              'customer_id': widget.customerid,
                              'address': addressList,
                            }),
                          );
                          print(response.body);
                        if (response.statusCode == 201) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context){
                              return CustomerHomePage(customer_id: widget.customerid, address: _addressController.text,);
                            }),
                            (route){
                              return false;
                            }
                          );
                        }
                        else{
                          SnackBar messagesnackbar = const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("There some error on server.")
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            (messagesnackbar)
                          );
                        }
                      }
                      else{
                        final url = Uri.parse("https://trashandler-api-s-1-259j.onrender.com/vend_location/");
                        var request = http.MultipartRequest('POST', url);

                        request.fields['vendor_id'] = widget.vendorid;
                        request.fields['latitude'] = _selectedPosition!.latitude.toString();
                        request.fields['longitude'] = _selectedPosition!.latitude.toString();

                        var response = await request.send();
                        print("${await response.stream.bytesToString()}");
                        if (response.statusCode == 201) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context){
                              return VendorHomeScreen(vendorid: widget.vendorid);
                            }),
                            (route){
                              return false;
                            }
                          );
                        }
                        else{
                          SnackBar messagesnackbar = const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("There some error on server.")
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            (messagesnackbar)
                          );
                        }

                      }
                        
                },
                style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFF693907),
                        fixedSize: Size(100, 25),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                child: Text('Confirm Location', style: TextStyle(color: Colors.white),),
              ),
            ),
          Positioned(
            bottom: 150,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Color(0xFF693907),
              onPressed: _goToCurrentLocation,
              child: Icon(Icons.my_location, color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }
}