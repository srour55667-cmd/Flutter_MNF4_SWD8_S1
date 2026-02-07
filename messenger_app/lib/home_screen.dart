import 'package:flutter/material.dart';
import 'package:messenger_app/chat_model.dart';

import 'const.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ChatModel> chats = chatsFromApi
        .map((e) => ChatModel.fromJson(e))
        .toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: customIcon(Icons.menu_rounded),
        ),
        title: const Text(
          "Chats",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          customIcon(Icons.camera_alt_outlined),
          SizedBox(width: 20),
          customIcon(Icons.edit),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(19),
                ),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: chats.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Column(
                    children: [
                      customCircleAvatar(chats[index]),
                      Text(chats[index].name!),
                    ],
                  ),
                ),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: chats.length,
              itemBuilder: (context, index) => customChat(chats[index]),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }

  Widget customCircleAvatar(ChatModel model) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(model.img ?? ""),
        ),
        Positioned(
          bottom: 5,
          right: 0,
          child: CircleAvatar(radius: 8, backgroundColor: Colors.green),
        ),
      ],
    );
  }
}

customChat(ChatModel model) {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(model.img ?? ""),
            ),
            Positioned(
              bottom: 5,
              right: 0,
              child: CircleAvatar(radius: 8, backgroundColor: Colors.green),
            ),
          ],
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.name ?? "",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(model.msg ?? ""),
          ],
        ),
        Spacer(),
        Text(model.createdAt ?? ""),
      ],
    ),
  );
}

Widget customIcon(IconData icon) {
  return CircleAvatar(
    radius: 22,
    backgroundColor: Colors.grey.withValues(alpha: 0.2),
    child: Icon(icon),
  );
}
