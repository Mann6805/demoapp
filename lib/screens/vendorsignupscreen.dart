// ignore_for_file: no_leading_underscores_for_local_identifiers, body_might_complete_normally_nullable, non_constant_identifier_names, use_build_context_synchronously

import 'package:demoapp/controllers/vendorsignupcontroller.dart';
import 'package:demoapp/screens/vendorloginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VendorSignupScreen extends StatefulWidget {
  const VendorSignupScreen({super.key});

  @override
  State<VendorSignupScreen> createState() => _VendorSignupScreenState();
}

class _VendorSignupScreenState extends State<VendorSignupScreen> {

  bool isLoading = false;
  var vendorSignupForm = GlobalKey<FormState>();
  final TextEditingController _vendor_name = TextEditingController();
  final TextEditingController _vendor_number = TextEditingController();
  final TextEditingController _vendor_email = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final double _deviceWidth = MediaQuery.of(context).size.width;
    final double _deviceHeight = MediaQuery.of(context).size.height;
    final String str = "${" "*(_deviceWidth/29.5).toInt()}SignUp";

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
                title: Text(
                  str,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent,
              ),
              body: Center(
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
                            height: 50,
                          ),
                          const Stack(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Color(0XFF9C9898),
                                foregroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  size: 90,
                                ),
                              ),
                              Positioned(
                                top: 75,
                                left: 75,
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Color(0XFF48AC38),
                                )
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 21.241,
                          ),
                          const Text(
                            "Upload your profile picture",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: _deviceWidth,
                            height: _deviceHeight/1.64,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(70))
                            ),
                            child: Form(
                              key: vendorSignupForm,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20, top: 70),
                                    child: TextFormField(
                                      controller: _vendor_name,
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: (value){
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
                                            color: Color(0xFF693907), 
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(15))
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF693907), 
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(15))
                                        ),
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Color(0xFF693907),
                                        ),
                                        labelText: "Name",
                                        labelStyle: TextStyle(
                                          color: Color(0XFF9C9898)
                                        )
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                                    child: TextFormField(
                                      controller: _vendor_number,
                                       autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: (value){
                                        if(value == null || value.isEmpty || value.length !=10){
                                          return "Number is required";
                                        }
                                      },
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      keyboardType: TextInputType.number,
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
                                            color: Color(0xFF693907), 
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(15))
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF693907), 
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(15))
                                        ),
                                        prefixIcon: Icon(
                                          Icons.phone_iphone,
                                          color: Color(0xFF693907),
                                        ),
                                        labelText: "Mobile number",
                                        labelStyle: TextStyle(
                                          color: Color(0XFF9C9898)
                                        )
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
                                    child: TextFormField(
                                      controller: _vendor_email,
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
                                            color: Color(0xFF693907), 
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(15))
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF693907), 
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(15))
                                        ),
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: Color(0xFF693907),
                                        ),
                                        labelText: "Email (Optional)",
                                        labelStyle: TextStyle(
                                          color: Color(0XFF9C9898)
                                        )
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: _deviceHeight/16.5,
                                    width: _deviceWidth/1.1,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (vendorSignupForm.currentState!.validate()) {
                                          isLoading = true;
                                          setState(() {});
                                          try{
                                            await VendorSignupController.createProfile(_vendor_name.text, _vendor_number.text, _vendor_email.text, context);
                                          }
                                          catch(e){};
                                          isLoading = false;
                                          setState(() {});
                                        }
                                      }, 
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: (_vendor_name.text.isNotEmpty && _vendor_number.text.length == 10 ) ? const Color(0xFF693907) : const Color(0XFF9C9898),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                        ),
                                      ),
                                      child: isLoading 
                                      ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      ) 
                                      : const Text(
                                        "Continue",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                        ),
                                      )
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Already have an account?",
                                        style: TextStyle(
                                          fontSize: 16
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return const VendorLoginScreen();
                                              }
                                            )
                                          );
                                        },
                                        child: const Text(
                                          "Login",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Color(0xFF693907)
                                          ),
                                        )
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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