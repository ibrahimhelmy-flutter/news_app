import 'package:flutter/material.dart';
import 'package:news_app/model/artical.dart';
import 'package:news_app/widget/article_item.dart';

class Homepage extends StatelessWidget {
  final Future<List<Article>> articles;

  const Homepage({Key key, this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        FutureBuilder<List<Article>>(
            future: articles,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        Article article = snapshot.data[index];
                        return ArticalItemBuild(article: article);
                      }),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ],
    ));
  }
}
