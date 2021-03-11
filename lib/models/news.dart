class News{
  String title;
  String description;
  String publishedAt;
  String urlToImage;
  String url;

  News({this.title,this.description,this.publishedAt,this.urlToImage,this.url});

  factory News.fromJson(Map json){
    return News(
      title: json['title'],
      description: json['description'],
      publishedAt: json['publishedAt'],
      urlToImage: json['urlToImage'],
      url: json['url'],
    );
  }

}