import 'package:chat_app/Models/message.dart';
import 'package:chat_app/Widgtes/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Widgtes/Chat_Buble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);
  static String id = "ChatPage";

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference message =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: message.orderBy(KCreatTime, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Colors.deepPurple,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(KLogo, height: 50),
                  const Text(
                    "Scholar Chat",
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(children: [
              Expanded(
                child: ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) =>
                        messageList[index].id == email
                            ? ChatBuble(
                                message: messageList[index],
                              )
                            : ChatBubleForFriend(
                                message: messageList[index],
                              )),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: controller,
                  onSubmitted: (data) {
                    message.add({
                      KMessage: data,
                      KCreatTime: DateTime.now(),
                      "id": email
                    });
                    controller.clear();
                    scrollController.animateTo(
                      scrollController.position.minScrollExtent,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                    );
                  },
                  cursorColor: Colors.purple,
                  decoration: InputDecoration(
                    suffixIcon:
                        const Icon(Icons.send, color: Colors.deepPurple),
                    hintText: "send message",
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(15)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              )
            ]),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

//عكس الليست reverse: true,
// خلا المؤشر يشير لبدايتها  0,min
//عكس ترتيب الرسائل حسب dec
