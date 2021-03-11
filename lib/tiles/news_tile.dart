import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/news.dart';
import 'package:url_launcher/url_launcher.dart';

Widget newsTile(News news){
  String date=news.publishedAt.substring(0,10);
  date='${date.substring(8,10)}-${date.substring(5,7)}-${date.substring(0,4)}';
  String time=news.publishedAt.substring(11,16);
  /*var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(news.publishedAt, true);
  print(dateTime);*/

  return GestureDetector(
    onTap: () async {
      String url = news.url;
      if (await canLaunch(url)) {
      await launch(url);
      } else {
      throw 'Could not launch $url';
      }
    },
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Container(
            color: Colors.grey,
            height: 100,
            width: 100,
            child:  (news.urlToImage!=null && news.urlToImage!='') ? Image.network(news.urlToImage,fit: BoxFit.cover,) : Icon(Icons.book_outlined,size: 50,color: Colors.white,),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(news.title ?? '',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),overflow: TextOverflow.visible,),
                  SizedBox(height: 7,),
                  Text(news.description ?? '',overflow: TextOverflow.ellipsis,),
                  SizedBox(height: 15,),
                  Align(alignment: Alignment.bottomRight,child: Text(('$date $time') ?? '',overflow: TextOverflow.visible,textAlign: TextAlign.end,style: TextStyle(color: Colors.grey),)),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}