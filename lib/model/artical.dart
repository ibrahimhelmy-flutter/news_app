class Article {
  final String title;
  final String description;
  final String imageUrl;
  final String articleUrl;
  final String author;
  final String content;

  Article(
      {this.title,
      this.description,
      this.imageUrl =
          "https://cdni.rt.com/media/pics/2021.04/original/60815c8442360438a4027749.png",
      this.articleUrl,
      this.author,
      this.content});

  factory Article.fromJson(Map<String, dynamic> jsonData) {
    return Article(
        title: jsonData["title"],
        description: jsonData['description'],
        imageUrl: jsonData['urlToImage'],
        articleUrl: jsonData['url'],
        author: jsonData['author'] ?? jsonData['title'],
        content: jsonData["content"]);
  }
}
