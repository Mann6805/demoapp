// ignore_for_file: no_leading_underscores_for_local_identifiers, body_might_complete_normally_nullable

import 'dart:io';

import 'package:demoapp/controllers/businessscreencontroller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BusinessScreen extends StatefulWidget {

  final String mobile_no;
  final String vendor_id;

  const BusinessScreen({super.key, required this.mobile_no, required this.vendor_id});

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {

  bool isLoading = false;
  bool ispan = false;
  bool isbusiness = false;
  late File panfile;
  late File businessfile;
  var vendorBusinessForm = GlobalKey<FormState>();
  final TextEditingController _business_name = TextEditingController();
  final TextEditingController _business_gst = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final double _deviceWidth = MediaQuery.of(context).size.width;
    final double _deviceHeight = MediaQuery.of(context).size.height;
    final ImagePicker imagePicker = ImagePicker();

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
              body: Form(
                key: vendorBusinessForm,
                child: SingleChildScrollView(
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
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
                                  child: TextFormField(
                                    controller: _business_name,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if(value == null || value.isEmpty){
                                        return "Name is required";
                                      }
                                    },
                                    decoration: const InputDecoration(
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
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red, 
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(15))
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red, 
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
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
                                  child: TextFormField(
                                    controller: _business_gst,
                                    decoration: const InputDecoration(
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
                                  child: Row (
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      const Text(
                                        "PAN card"
                                      ),
                                      const SizedBox(
                                        width: 170,
                                      ),
                                      ispan ? const Icon(
                                        Icons.check,
                                        color: Color(0XFF48AC38),
                                      ):
                                      const Icon(
                                        Icons.upload_rounded,
                                        color: Color(0xFF693907),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          final XFile? file = await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50);
                                          panfile = File(file!.path);
                                          ispan = true;
                                          setState(() {});
                                          print("${panfile}");
                                        },
                                        child: ispan? 
                                        const Text(
                                          "Uploaded",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200
                                          ),
                                        ):
                                        const Text(
                                          "Upload",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200
                                          ),
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
                                  child: Row (
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      const Text(
                                        "Business Picture"
                                      ),
                                      const SizedBox(
                                        width: 120,
                                      ),
                                      isbusiness? const Icon(
                                        Icons.check,
                                        color: Color(0XFF48AC38),
                                      ):
                                      const Icon(
                                        Icons.upload_rounded,
                                        color: Color(0xFF693907),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          final XFile? file = await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50);
                                          businessfile = File(file!.path);
                                          print(businessfile.path);
                                          isbusiness = true;
                                          setState(() {});
                                        },
                                        child: isbusiness?
                                        const Text(
                                          "Uploaded",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200
                                          ),
                                        ): 
                                        const Text(
                                          "Upload",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
                                  child: ElevatedButton(
                                    onPressed: () async {

                                      if(vendorBusinessForm.currentState!.validate()){
                                        isLoading = true;
                                        setState(() {});
                                        try{
                                          await BusinessScreenController.createProfile(widget.vendor_id, widget.mobile_no, _business_name.text, _business_gst.text, panfile, businessfile, context);
                                        }
                                        catch(e){
                                          print(e);
                                        };
                                        isLoading = false;
                                        setState(() {});
                                      }
                                      
                                    }, 
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: (_business_name.text.isNotEmpty && ispan && isbusiness) ? const Color(0xFF693907) : const Color(0XFF9C9898),
                                      fixedSize: Size(_deviceWidth, _deviceHeight/15),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                      ),
                                    ),
                                    child: isLoading ?
                                      const CircularProgressIndicator(
                                        color: Colors.white,
                                      ) : const Text(
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
              ),
            )
          ],
        ),
      );
  }
}