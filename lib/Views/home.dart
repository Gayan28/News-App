// ignore_for_file: prefer_typing_uninitialized_variables, unused_field, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:news_api_project/Views/artical_view.dart';
import 'package:news_api_project/Views/category_news.dart';
import 'package:news_api_project/helper/data.dart';
import 'package:news_api_project/helper/news.dart';
import 'package:news_api_project/models/article_model.dart';
import 'package:news_api_project/models/category_model.dart';
import 'package:cached_network_image/cached_network_image.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<ArticleModel> articals = [];

  bool _loading = false;

  @override
  void initState() { 
    super.initState();
    getNews();
    categories = getCategories();
  }

  getNews() async{
    HeadlinesNews newsClass = HeadlinesNews();
    await newsClass.getNews();
    articals = newsClass.news;
    setState(() {
      _loading= false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            Text('Daily'),
            Text('News',
            style: TextStyle(
              color: Colors.blue,
            ),
            ),
          ]
          ),
          centerTitle: true,
          elevation: 0.0,
      ),

      body: _loading ? Center(
        child: Container(
          child: const CircularProgressIndicator(),
        ),
      ):
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
          child:  Column(
            children: <Widget>[
          
              ///Categories
              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 70,
                child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return CategoryTile(
                      imageUrl: categories[index].imageUrl,
                      categoryName: categories[index].categorieName,
                    );
                  }
                  ),
              ),
          
              ///Blogs
              
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: ListView.builder(
                  itemCount: articals.length,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index){
                    return BlogTile(
                      imageUrl: articals[index].urlToImage, 
                      title: articals[index].title, 
                      desc: articals[index].description,
                      url: articals[index].url,
                      );
                  }),
              )
            ]
            ),
                ),
        ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  
  final String imageUrl, categoryName;
  const CategoryTile({super.key, required this.imageUrl, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) =>CategoryNews(category: categoryName.toLowerCase(),
            )
            ));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Stack(
          children:<Widget> [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child:Image.network(imageUrl,fit: BoxFit.cover,  height: 60,width: 120,)
            ),
              Container(
                alignment: Alignment.center,
                height: 60,width: 120,
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(6),
                   color: Colors.black.withOpacity(0.2),                
                  ),
                child: Text(categoryName,
                style: const TextStyle(
                  color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),
                  ),
              )
            
          ],
          ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl,title,desc,url;
  const BlogTile({super.key, required this.imageUrl, required this.title, required this.desc, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ArticleView(
            blogUrl: url
          ),
          )
          );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          children:<Widget> [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl)),
            Text(title,style: const TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.w500
            ),),
            const SizedBox(height: 8,),
            Text(desc,style: const TextStyle(
              color: Colors.black54
            ),),
          ]),
      ),
    );
  }
}