import 'package:flutter/material.dart';
import 'package:newsapp/servec/newsApp.dart';
// import 'package:newsapp/api/models.dart';
import 'package:newsapp/widget/customwidet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late Future<List<model>> futureNews;
  // List<model> article = [];

  @override
  void initState() {
    super.initState();
    getnew();
  }

  Future<void> getnew() async {
    // article = await NewsService().getnews();
    setState(() {});
  }

  int index = 0;
  List<String> categories = [
    'general',
    'sports',
    'business',
    'entertainment',
    'health',
    'science',
    'technology',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'News App',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: NewsService().getnews(ca: categories[index]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("snapshot has error"));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Customwidet(moodel: snapshot.data![index]);
              },
            );
          } else {
            return Container();
          }
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap:
            (value) => setState(() {
              index = value;
            }),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'general'),
          BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'bussiness',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_call),
            label: 'entertainment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety),
            label: 'healthy',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone_android),
            label: 'technology',
          ),
        ],
      ),
    );
  }
}
