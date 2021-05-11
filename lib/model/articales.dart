class Articles {
  final List<dynamic>
      articles; //---هنا المتغير بيرجع ليست دينامك مش مقال لان اى داتا بترجع بتكون دينامك

  Articles({this.articles}); //---كونستؤكتر

  factory Articles.fromJson(Map<String, dynamic> jsonData) {
    return Articles(articles: jsonData['articles']);
  }
}
