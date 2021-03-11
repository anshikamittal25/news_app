class SearchOptions{
  String category;
  String q;

  SearchOptions({this.category,this.q});

  Map<String,dynamic> toJson()=>{
  ...((q!=null || q!='')?{'q':q}:{}),
  ...((category!=null)?{'category':category}:{}),
  };

}