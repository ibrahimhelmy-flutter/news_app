import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/artical.dart';
import 'package:news_app/views/artical_details.dart';

class ArticalItemBuild extends StatelessWidget {
  const ArticalItemBuild({
    Key key,
    @required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticalDetailes(
                      article: article,
                    )));
      },
      child: Card(
        child: Stack(
          children: [
            CachedNetworkImage(
              width: double.infinity,
              imageUrl: article.imageUrl != null
                  ? article.imageUrl.isNotEmpty
                      ? article.imageUrl
                      : null
                  : "https://images.unsplash.com/32/Mc8kW4x9Q3aRR3RkP5Im_IMG_4417.jpg?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YmFja2dyb3VuZHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
            Positioned(
              child: Container(
                  height: 70,
                  color: Colors.black.withOpacity(.50),
                  child: Text(
                    article.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    maxLines: 3,
                    textDirection: TextDirection.rtl,
                  )),
              bottom: 0,
              right: 0,
              left: 0,
            )
          ],
        ),
      ),
    );
  }
}
