import 'package:dio/dio.dart';
import 'package:newsapp/api/models.dart';

class NewsService {
  var dio = Dio();

  Future<List<model>> getnews({required String ca}) async {
    try {
      var response = await dio.get(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=d297d095887f448d9f72824b621990ae&category=$ca",
      );

      Map<String, dynamic> jsonData = response.data as Map<String, dynamic>;
      List<dynamic> articles = jsonData['articles'];

      List<model> articleList = [];

      for (var a in articles) {
        final articleMap = a as Map<String, dynamic>;
        model art = model(
          author: articleMap['author'] ?? "unknown",
          title: articleMap['title'] ?? "no title",
          description: articleMap['description'] ?? "no desc",
          url: articleMap['url'] ?? "",
          urlToImage:
              articleMap['urlToImage'] ??
              "https://tse1.mm.bing.net/th/id/OIP.1giPAI3L-CVukyQUZZ6qXgHaFj?rs=1&pid=ImgDetMain&cb=idpwebp2&o=7&rm=3",
          publishedAt: articleMap['publishedAt'] ?? "000",
        );
        articleList.add(art);
      }

      return articleList;
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
