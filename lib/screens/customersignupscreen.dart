// ignore_for_file: no_leading_underscores_for_local_identifiers, body_might_complete_normally_nullable, non_constant_identifier_names, use_build_context_synchronously

import 'package:demoapp/controllers/customersignupcontroller.dart';
import 'package:demoapp/screens/customerloginscreen.dart';
import 'package:demoapp/screens/vendorloginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomerSignupScreen extends StatefulWidget {
  const CustomerSignupScreen({super.key});

  @override
  State<CustomerSignupScreen> createState() => _CustomerSignupScreenState();
}

class _CustomerSignupScreenState extends State<CustomerSignupScreen> {

  bool isLoading = false;
  var customerSignupForm = GlobalKey<FormState>();
  final TextEditingController _customer_number = TextEditingController();
  final TextEditingController _customer_email = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final double _deviceWidth = MediaQuery.of(context).size.width;
    final double _deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: _deviceHeight,
              minWidth: _deviceWidth
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  SizedBox(
                    height: _deviceHeight/1.9,
                    child: Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF693907),
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(60)
                            )
                          ),
                          width: _deviceWidth,
                          height: _deviceHeight/4,
                          child: const Center(
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                        top: _deviceHeight/7.5,
                        left: 30,
                        right: 30,
                        child: const Image(
                          image: AssetImage(
                            "assets/images/login.png",
                          ),
                        ),
                      ),
                      ]
                    ),
                  ),
                  Form(
                    key: customerSignupForm,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                          child: TextFormField(
                            controller: _customer_number,
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
                              labelText: "Enter your phone number",
                              labelStyle: TextStyle(
                                color: Color(0XFF9C9898)
                              )
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                          child: TextFormField(
                            controller: _customer_email,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Email is required";
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
                                Icons.email,
                                color: Color(0xFF693907),
                              ),
                              labelText: "Enter your Email Id",
                              labelStyle: TextStyle(
                                color: Color(0XFF9C9898)
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
                    child: ElevatedButton(
                      onPressed: () async {
                        if(customerSignupForm.currentState!.validate()){
                          isLoading = true;
                          setState(() {});
                          try{
                            await CustomerSignupController.createProfile(_customer_number.text, _customer_email.text, context);
                          }
                          catch(e){};
                          isLoading = false;
                          setState(() {});
                        }
                      }, 
                      style: OutlinedButton.styleFrom(
                        backgroundColor: (_customer_number.text.length == 10 && _customer_email.text.isNotEmpty) ? const Color(0xFF693907): const Color(0XFF9C9898),
                        fixedSize: Size(_deviceWidth, _deviceHeight/15),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      child: isLoading 
                      ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                      : const Text(
                        "Send OTP",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      )
                    ),
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
                                return const CustomerLoginScreen();
                              }
                            ),
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        )
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Vendor?",
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
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        )
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}