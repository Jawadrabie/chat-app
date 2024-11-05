import 'package:flutter/material.dart';

class Custom_Buttom extends StatelessWidget {
  Custom_Buttom({super.key, this.ontap, required this.text});

  VoidCallback? ontap;
  String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: Colors.white,
        height: 60,
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: ontap,
        child: Text(
          text,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ));

    // GestureDetector(
    //   onTap:ontap,
    //   child: Container(
    //     decoration: BoxDecoration(
    //         color: Colors.white, borderRadius: BorderRadius.circular(15)),
    //     child: Center(
    //         child: Text(text,
    //       style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
    //     )),
    //     width: double.infinity,
    //     height: 55,
    //   ),
    // );
  }
}
