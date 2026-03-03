import 'package:flutter/material.dart';
import 'package:quizeapp/screens/questionpages.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quize App "),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.all(20),
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  Text(
                    "Quize App ",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.question_mark, size: 50),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "ready to play ? ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Questionpages(),
                        ),
                      );
                    },
                    child: Text("start now"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
