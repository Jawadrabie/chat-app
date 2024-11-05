import 'package:chat_app/Models/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatBuble extends StatelessWidget {
  ChatBuble({Key? key, required this.message}) : super(key: key);
  Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        // alignment: Alignment.centerLeft,
        margin: const EdgeInsets.all(8),
        padding:
            const EdgeInsets.only(left: 16, top: 32, right: 32, bottom: 32),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
            color: Color(0x295379FF)),
        child: Text(
          message.message,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class ChatBubleForFriend extends StatelessWidget {
  ChatBubleForFriend({Key? key, required this.message}) : super(key: key);
  Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        // alignment: Alignment.centerLeft,
        margin: const EdgeInsets.all(8),
        padding:
            const EdgeInsets.only(left: 16, top: 32, right: 32, bottom: 32),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: Color(0x8C6281FF),
        ),
        child: Text(
          message.message,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

