import 'package:chat_app/Screen/Chat_Page.dart';

import 'package:chat_app/Widgtes/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../Widgtes/Custom_Bottom.dart';
import '../Widgtes/Custom_TextFormField.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static String id = "RegisterPage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;
  String? password;

  GlobalKey<FormState> formkey = GlobalKey();
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: const CircularProgressIndicator(
        color: Colors.red,
      ),
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: KPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Image.asset(KLogo, height: 100),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Scholar Chat",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: "Pacifico"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 75,
                ),
                const Row(
                  children: [
                    Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 11,
                ),
                CustomTextField(
                  Hint: "Email",
                  onchanged: (data) {
                    email = data;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  Hint: "Password",
                  onchanged: (data) {
                    password = data;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                // Custom_Bottom(
                //   ontap: () async {
                //     await HandleOnTap(context);
                //   },
                //   text: "Register",
                // ),
                Custom_Buttom(
                  ontap: () async {
                    if (formkey.currentState!.validate()) {
                      isloading = true;
                      setState(() {});
                      try {
                        await regesterUser();
                        print("==========================================");
                        ShowSnackBar(context, "Success", Colors.green);
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'weak-password') {
                          ShowSnackBar(context,
                              'The password provided is too weak.', Colors.red);
                        } else if (ex.code == 'email-already-in-use') {
                          ShowSnackBar(
                              context,
                              'The account already exists for that email.',
                              Colors.red);
                        } else if (ex.code == 'invalid-email') {
                          ShowSnackBar(
                              context,
                              'Invalid email address. Please enter a valid email address.',
                              Colors.red);
                        } else if (ex.code == 'network_error') {
                          ShowSnackBar(
                              context,
                              'No internet connection. Please check your connection and try again.',
                              Colors.red);
                        }
                      } on Exception catch (ex) {
                        ShowSnackBar(
                            context, "$ex there was an error", Colors.red);
                      }
                      isloading = false;
                      setState(() {});
                    }
                  },
                  text: "Register",
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "have an accont? ",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        returnToPreviousPage(context, email);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Color(0x899FADFF),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void returnToPreviousPage(BuildContext context, String? data) {
    Navigator.pop(context, data);
  }

  Future<void> regesterUser() async {
    //  FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }

  void ShowSnackBar(BuildContext context, String message, Color TheColor) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: TheColor, content: Text(message)));
  }
}
