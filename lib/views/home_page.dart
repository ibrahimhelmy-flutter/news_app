import 'package:flutter/material.dart';

import 'package:news_app/data/data.dart';
import 'package:news_app/model/artical.dart';
import 'package:news_app/widget/article_item.dart';
import 'package:news_app/widget/category_item.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

//business entertainment general health science sports technology
class _HomepageState extends State<Homepage> {
  final double size = 100;
  final List<String> categoryList = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology"
  ];
  String _selectedCat = "technology";
  Future<List<Article>> articles;
  @override
  void initState() {
    super.initState();
    fetchData("technology");
  }

  void fetchData(String cat) {
    articles = NewsApi().fetchArticles(cat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Flutter",
                style: TextStyle(color: Colors.black),
              ),
              Text(" News", style: TextStyle(color: Colors.green))
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
                height: size,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCat = categoryList[index];
                            fetchData(_selectedCat);
                            print(_selectedCat);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CategoryItemBuild(
                            cat: categoryList[index],
                          ),
                        ),
                      );
                    })),
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
