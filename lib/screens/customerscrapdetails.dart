// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:demoapp/controllers/scrapdetailscontroller.dart';
import 'package:demoapp/screens/customerpickupscheduling.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class CustomerScrapDetails extends StatefulWidget {
  var customerid;
  String text;
  CustomerScrapDetails({super.key, required this.customerid, required this.text});

  @override
  State<CustomerScrapDetails> createState() => _CustomerScrapDetailsState();
}

class _CustomerScrapDetailsState extends State<CustomerScrapDetails> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final int _maxLength = 300;
  final ImagePicker imagePicker = ImagePicker();
  late File scrapphoto;
  bool isLoading = false;
  bool isscrap = false;

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
                  const CircleAvatar(
                    backgroundColor: Color(0xFF693907),
                    radius: 10,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Scrap Details",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "Schedule Pickup",
                    style: TextStyle(fontWeight: FontWeight.w300),
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
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Please Provide the below scrap information",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Provide the Scrap Lumpsum Weight",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _weightController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Lumpsum weight',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const Text('Kg', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              const Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Scrap Description (Optional)",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _descriptionController,
                      maxLength: _maxLength,
                      minLines: 5,
                      maxLines: 10,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        counterText:
                            '${_descriptionController.text.length}/$_maxLength',
                      ),
                    ),
                  ],
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                            onTap: () async {
                              final XFile? file = await imagePicker.pickImage(
                                  source: ImageSource.camera, imageQuality: 50);
                              if (file != null) {
                                scrapphoto = File(file.path);
                                setState(() {
                                  isscrap = true;
                                });
                              }
                            },
                            child: isscrap
                                ? Icon(Icons.done)
                                : const Image(
                                    height: 60,
                                    width: 60,
                                    image: AssetImage(
                                        "assets/images/camera.png"))),
                        Transform.translate(
                          offset: Offset(25, 2),
                          child: Text(
                            "Upload live scrap pictures",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            final XFile? file = await imagePicker.pickImage(
                                source: ImageSource.gallery, imageQuality: 50);
                            if (file != null) {
                              scrapphoto = File(file.path);
                              setState(() {
                                isscrap = true;
                              });
                            }
                          },
                          child: isscrap? 
                            Icon(Icons.done)
                            :Image(
                              height: 60,
                              width: 60,
                              image: AssetImage("assets/images/gallery.png")),
                        ),
                        Transform.translate(
                          offset: Offset(25, 0),
                          child: Text(
                            "Upload scrap pictures",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Landmark: WhiteFeild",
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Icon(
                          Icons.edit,
                          color: Colors.brown,
                          size: 20,
                        )
                      ],
                    )),
              ),
              ElevatedButton(
                  onPressed: () {
                      if (_weightController.text.length != 0 && _descriptionController.text.length != 0 && isscrap ){
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context){
                              return CustomerPickupScheduling(customerid: widget.customerid, weight: _weightController.text, description: _descriptionController.text, photo: scrapphoto, text: widget.text,);
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
        ));
  }
}
