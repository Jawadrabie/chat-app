import 'package:chat_app/Screen/Chat_Page.dart';
import 'package:chat_app/Screen/Register_Page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../Widgtes/Constants.dart';
import '../Widgtes/Custom_Bottom.dart';
import '../Widgtes/Custom_TextFormField.dart';
import '../helper/Show_SnackBar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formkey = GlobalKey();

  bool isloading = false;
  String? email;

  String? password;
  static String id = "LoginPage";

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      progressIndicator: const CircularProgressIndicator(color: Colors.red),
      child: Scaffold(
        backgroundColor: KPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 100,
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
                  height: 100,
                ),
                const Row(
                  children: [
                    Text(
                      "Login",
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
                  obscureText: true,
                ),
                const SizedBox(
                  height: 25,
                ),
                Custom_Buttom(
                  ontap: () async {
                    if (formkey.currentState!.validate()) {
                      isloading = true;
                      setState(() {});
                      try {
                        await LoginUser();
                        ShowSnackBar(context, "Success", Colors.green);
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'with exception') {
                          ShowSnackBar(context, 'No user found for that email.',
                              Colors.red);
                        } else if (e.code == 'wrong-password') {
                          ShowSnackBar(
                              context,
                              'Wrong password provided for that user.',
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
                  text: "Login",
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an accont? ",
                        style: TextStyle(color: Colors.white)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Color(0x899FADFF)),
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

  Future<void> LoginUser() async {
//     FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
