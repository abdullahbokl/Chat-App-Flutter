import 'package:chatapp/models/message_model.dart';
import 'package:chatapp/screens/widgets/bubblechat_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapp/constants.dart';
import 'package:chatapp/firebase/firebase_services.dart';
import 'package:chatapp/screens/pages/home_page.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  static const route = 'ChatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // variables
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  TextEditingController tfController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  List<MessageModel> messagesList = [];
  List<QueryDocumentSnapshot<Object?>> data = [];

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          //
          chechIfDataExists(snapshot);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(kLogoPath),
                  const Text('Chat'),
                ],
              ),
              centerTitle: true,
              leading: IconButton(
                  onPressed: () async {
                    await FireBaseServices.signOut();
                    Navigator.of(context).pushReplacementNamed(HomePage.route);
                  },
                  icon: Icon(Icons.logout_outlined)),
            ),
            body: !snapshot.hasData
                ? Center(
                    child: Text('Loading...'),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          reverse: true,
                          controller: _scrollController,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return BubbleChatWidget(
                                message: messagesList[index].messageContent,
                                is_me: email == messagesList[index].id
                                    ? true
                                    : false);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: tfController,
                          onSubmitted: (value) {
                            sendMessage(value, email);
                            tfController.clear();
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: kPrimaryColor),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: () {
                                sendMessage(tfController.text, email);
                                tfController.clear();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        });
  }

  // functions

  void sendMessage(String text, var data) {
    print("asdasdadasdasda$data");
    messages.add({
      kMessageContent: text,
      kCreatedAt: DateTime.now(),
      'id': data,
    });
    _scrollController.animateTo(0,
        duration: Duration(microseconds: 500), curve: Curves.easeOut);
  }

  chechIfDataExists(snapshot) {
    if (snapshot.hasData) {
      messagesList = [];
      data = snapshot.data!.docs;
      for (int i = 0; i < data.length; i++) {
        messagesList.add(MessageModel.fromJson(data[i]));
      }
    }
  }
}
