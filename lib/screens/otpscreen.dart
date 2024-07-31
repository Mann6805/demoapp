// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:demoapp/screens/successscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Otpscreen extends StatefulWidget {

  final String mobileno;
  late final String verificationid;
  final bool iscustomer;
  late String customerid;
  late String vendorid;

  Otpscreen({super.key, required this.verificationid, required this.mobileno, required this.iscustomer, required this.customerid, required this.vendorid});

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {

  bool canResendOTP = true;
  bool isLoading = false;
  final TextEditingController _otp1 = TextEditingController();
  final TextEditingController _otp2 = TextEditingController();
  final TextEditingController _otp3 = TextEditingController();
  final TextEditingController _otp4 = TextEditingController();
  final TextEditingController _otp5 = TextEditingController();
  final TextEditingController _otp6 = TextEditingController();

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
                    height: _deviceHeight/1.95,
                    child: Stack(
                      children: [
                        Positioned(
                          top: - _deviceHeight/2,
                          left: - _deviceWidth/2.3,
                          child: const CircleAvatar(
                            radius: 370,
                            backgroundColor: Color(0xFF693907),
                          ),
                        ),
                        Positioned(
                          top: _deviceHeight/9.5,
                          left: _deviceWidth/2.352,
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              )
                          )
                        ),
                        Positioned(
                        top: _deviceHeight/7.5,
                        left: 30,
                        right: 30,
                        child: const Image(
                          image: AssetImage(
                            "assets/images/otp.png",
                          ),
                        ),
                      ),
                      ]
                    ),
                  ),
                  const Text(
                    "Enter the 6-digit code",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 49,
                          width: 49,
                          child: TextFormField(
                            controller: _otp1,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 1, left: 2.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF693907)
                                )
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF693907)
                                )
                              ),
                            ),
                            style: const TextStyle(
                              color: Color(0xFF693907),
                              fontSize: 20
                            ),
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1), 
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(
                          height: 49,
                          width: 49,
                          child: TextFormField(
                            controller: _otp2,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 1, left: 2.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF693907)
                                )
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF693907)
                                )
                              )
                            ),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF693907),
                              fontSize: 20
                            ),
                            inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(
                          height: 49,
                          width: 49,
                          child: TextFormField(
                            controller: _otp3,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 1, left: 2.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF693907)
                                )
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF693907)
                                )
                              )
                            ),
                            style: const TextStyle(
                              color: Color(0xFF693907),
                              fontSize: 20
                            ),
                            textAlign: TextAlign.center,
                            inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(
                          height: 49,
                          width: 49,
                          child: TextFormField(
                            controller: _otp4,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 1, left: 2.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF693907)
                                )
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF693907)
                                )
                              )
                            ),
                            style: const TextStyle(
                              color: Color(0xFF693907),
                              fontSize: 20
                            ),
                            textAlign: TextAlign.center,
                            inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(
                          height: 49,
                          width: 49,
                          child: TextFormField(
                            controller: _otp5,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 1, left: 2.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF693907)
                                )
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF693907)
                                )
                              )
                            ),
                            style: const TextStyle(
                              color: Color(0xFF693907),
                              fontSize: 20
                            ),
                            textAlign: TextAlign.center,
                            inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(
                          height: 49,
                          width: 49,
                          child: TextFormField(
                            controller: _otp6,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 1, left: 2.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF693907)
                                )
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF693907)
                                )
                              )
                            ),
                            style: const TextStyle(
                              color: Color(0xFF693907),
                              fontSize: 20
                            ),
                            textAlign: TextAlign.center,
                            inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "If you didn't recieve a code?",
                        style: TextStyle(
                          fontSize: 16
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () async {
                          
                            if(!canResendOTP){
                              SnackBar messagesnackbar = const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("Wait for a while.")
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                (messagesnackbar)
                              );
                            }
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: "+91"+widget.mobileno,
                              timeout: const Duration(seconds: 30),
                              verificationCompleted: (PhoneAuthCredential credential) {}, 
                              verificationFailed: (FirebaseAuthException ex){}, 
                              codeSent: (String verificationid, int? resendtoken) {
                                widget.verificationid = verificationid;
                                canResendOTP = false;
                                setState(() {});
                                Future.delayed(
                                  const Duration(seconds: 30),
                                  () {
                                    canResendOTP = true;
                                    setState(() {});
                                  }
                                );
                                
                              }, 
                              codeAutoRetrievalTimeout: (String verificationid) {}
                            ) ; 
                          
                        },
                        child: const Text(
                          "Resend",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        )
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
                    child: ElevatedButton(
                      onPressed: () async {
                        isLoading = true;
                        setState(() {});
                        final String otpText = _otp1.text+_otp2.text+_otp3.text+_otp4.text+_otp5.text+_otp6.text;
                        try{
                          PhoneAuthCredential credential = PhoneAuthProvider.credential(
                            verificationId: widget.verificationid, 
                            smsCode: otpText
                          );
                          await FirebaseAuth.instance.signInWithCredential(credential);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SuccessScreen(iscustomer: widget.iscustomer, customerid: widget.customerid, vendorid: widget.vendorid,);
                              }
                            )
                          );
                        }
                        catch(e){
                          SnackBar messagesnackbar = const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Wrong OTP")
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            (messagesnackbar)
                          );   
                        }
                        finally{
                          isLoading = false;
                          setState(() {});
                        }
                        
                      }, 
                      style: OutlinedButton.styleFrom(
                        backgroundColor: (_otp1.text.isNotEmpty && _otp2.text.isNotEmpty && _otp3.text.isNotEmpty && _otp4.text.isNotEmpty && _otp5.text.isNotEmpty && _otp6.text.isNotEmpty) ? const Color(0xFF693907)  : const Color(0XFF9C9898),
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
                        "Verify",
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
            ),
          ),
        ),
      ),
    );
  }
}