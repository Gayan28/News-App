// ignore_for_file: unused_field, unused_import

import 'package:flutter/material.dart';
import 'package:news_api_project/Views/artical_view.dart';
import 'package:news_api_project/Views/home.dart';
import 'package:news_api_project/helper/news.dart';
import 'package:news_api_project/models/article_model.dart';

class CategoryNews extends StatefulWidget {
 
  final String category;
  const CategoryNews({super.key, required this.category});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {

  List<ArticleModel>articals = [];

 bool _loading = false;

@override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async{
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articals = newsClass.news;
    
    setState(() {
      _loading= false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
          actions:<Widget> [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.save))
          ],
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
          child:Column(children: [
            Container(
                  padding: const EdgeInsets.only(top: 16),
                  child: ListView.builder(
                    itemCount: articals.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index){
                      // print(articals[index].author);
                      // print(articals[index].title);
                      // print(articals[index].description);
                      // print(articals[index].url);
                      // print(articals[index].urlToImage);
                      // print(articals[index].content);
                      // print("+++++++++++++++++++++++++++++++$index");


                      return BlogTile(
                        imageUrl: articals[index].urlToImage, 
                        title: articals[index].title, 
                        desc: articals[index].description,
                        url: articals[index].url,
                        );
                    }),
                )
          ],
             ),
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
