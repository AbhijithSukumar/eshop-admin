// ignore_for_file: avoid_print, use_build_context_synchronously, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:eshop_admin/config/configuration.dart';
import 'package:eshop_admin/config/routes.dart';
import 'package:eshop_admin/config/styles.dart';
import 'package:eshop_admin/widgets/button.dart';
import 'package:eshop_admin/widgets/reuabletextfield.dart';
import 'package:eshop_admin/widgets/textbox.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  void login() async{
      String email =emailcontroller.text.trim();
      String password =passwordcontroller.text.trim();
      if(email==""||password=="")
      {
       print("fill all details");
      }
      else{
      try{
        UserCredential userCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null){
        Navigator.popUntil(context, (route) => route.isFirst);
           Navigator.pushReplacementNamed(context, Routes.home);
        }  
      }
      on FirebaseAuthException catch (exception){
        print("\n\n\n\n\n\n\n\n\n\n${exception.code.toString()}\n\n\n\n\n\n\n\n\n\n");
      }
      }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
       
        child: Padding(
          padding: EdgeInsets.all(MyConstants.screenHeight(context) * 0.01),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Sign in",
                  style: Styles.title(context),
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                "Welcome back. Please sign in to continue.",
                style: Styles.subtitlegrey(context),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              Textbox(
                hideText: false,
                tcontroller: emailcontroller,
                type: TextInputType.emailAddress,
                hinttext: 'Email',
                icon: Icon(Icons.email, color: Theme.of(context).primaryColor),
              ),
                 SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              Textbox(
                hideText: true,
                tcontroller: passwordcontroller,
                type: TextInputType.visiblePassword,
                hinttext: 'Password',
                icon: Icon(Icons.lock, color: Theme.of(context).primaryColor),
              ),
         SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              CustomLoginButton(text: "Sign in", onPress: login)
            ],
          ),
        ),
      ),
    );
  }
}
