import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/model/artical.dart';
import 'package:news_app/model/articales.dart';

//https://newsapi.org/v2/top-headlines?country=eg&category=technology&apiKey=$apiKe
class NewsApi {
  final String apiKey = "7a553c96880846e7b40d336aae6d021e";
  Future<List<Article>> fetchArticles(String category) async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=eg&category=$category&apiKey=$apiKey'));
      if (response.statusCode == 200) {
        print("sucess");
        // return sucess
        String body = response.body; //all of data  as String
        var jsonData = jsonDecode(body); //all of data as map
        Articles articles =
            Articles.fromJson(jsonData); //convert json to object of model
        List<Article> articlesList = articles.articles
            .map((e) => Article.fromJson(e))
            .toList(); //get  list of model

        print(articlesList);
        return articlesList;
      } else {
        //error in uri
        print("statusCode=${response.statusCode}");
      }
    } catch (e) {
      //error in server
      print("error");
      print(e);
    }
    return null;
  }
}
