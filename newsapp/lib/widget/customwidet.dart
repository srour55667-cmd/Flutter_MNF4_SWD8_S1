import 'package:flutter/material.dart';
import 'package:newsapp/api/models.dart';
import 'package:newsapp/webview/webview.dart';

class Customwidet extends StatelessWidget {
  const Customwidet({super.key, required this.moodel});
  final model moodel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Webview(uri: moodel.url)),
        );
      },
      child: Container(
        width: double.infinity,
        height: 800,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 20)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                moodel.urlToImage,
                height: 200,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 20),
            Text(
              moodel.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(moodel.description),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  moodel.author,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),

                Text(
                  moodel.publishedAt,
                  style: TextStyle(color: Colors.red, fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
