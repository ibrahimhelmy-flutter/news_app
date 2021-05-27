import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/artical.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticalDetailes extends StatelessWidget {
  final Article article;

  const ArticalDetailes({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.author ?? ""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text(
              article.title ?? "",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              textDirection: TextDirection.rtl,
            ),
            CachedNetworkImage(
              width: double.infinity,
              imageUrl: article.imageUrl != null
                  ? article.imageUrl.isNotEmpty
                      ? article.imageUrl
                      : "https://images.unsplash.com/32/Mc8kW4x9Q3aRR3RkP5Im_IMG_4417.jpg?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YmFja2dyb3VuZHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"
                  : "https://images.unsplash.com/32/Mc8kW4x9Q3aRR3RkP5Im_IMG_4417.jpg?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YmFja2dyb3VuZHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
            Text(
              article.description ?? "",
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 18),
            ),
            ElevatedButton(
                onPressed: () {
                  //  canLaunch(article.articleUrl);
                  launch(article.articleUrl);
                },
                child: Text("رابط الخبر"))
          ],
        ),
      ),
    );
  }

  void _launchURL() async => await canLaunch(article.articleUrl)
      ? await launch(article.articleUrl)
      : throw 'Could not launch $article.articleUrl';
}
