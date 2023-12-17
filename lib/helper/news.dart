// ignore_for_file: unused_local_variable, depend_on_referenced_packages

import 'dart:convert';
import 'package:news_api_project/models/article_model.dart';
import 'package:http/http.dart' as http;

class HeadlinesNews{
  
  List<ArticleModel> news =[];

  Future<void> getNews() async{
    String url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=e630d4e92324440b81fcf6dc28295017';

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    print(jsonData);
    
    if(jsonData['status'] == 'ok'){
      jsonData['articles'].forEach((element){

        if(element['urlToImage'] != null && element['description'] !=null){
          ArticleModel articleModel = ArticleModel(
            title: element['title']?? 'no data',
            author: element['author']?? 'no data',
            description:  element['description']?? 'no data',
            url:  element['url']?? 'no data',
            urlToImage:  element['urlToImage']?? 'no data',
            content:  element['content']?? 'no data'
          );
          news.add(articleModel);                 //add this module to news
        }
      }
      );
    }

  }
}

class CategoryNewsClass{
  
  List<ArticleModel> news =[];

  Future<void> getNews(String category) async{
    String url = 'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=e630d4e92324440b81fcf6dc28295017';

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    
    if(jsonData['status'] == 'ok'){

  

      jsonData['articles'].forEach((element){

        if(element['urlToImage'] != null && element['description'] !=null){
          ArticleModel articleModel = ArticleModel(
          
            title: element['title']?? 'no data',
            author: element['author']?? 'no data',
            description:  element['description']?? 'no data',
            url:  element['url']?? 'no data',
            urlToImage:  element['urlToImage']?? 'no data',
            content:  element['content']?? 'no data'
          );
          news.add(articleModel);                 //add this module to news
        }
      }
      );
    }

  }
}