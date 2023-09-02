import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/customListTile.dart';
import '../../models/news models/article_model.dart';
import '../../services/API/news_api.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App",
            style: TextStyle(
              color: Colors.white,
            )),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: FutureBuilder<List<Article>>(
          future: client.getArticle(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No articles available"));
            } else {
              List<Article> articles =
                  snapshot.data!; // Use ! to access non-null data
              return ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) =>
                      customListTile(articles[index]));
            }
          },
        ),
      ),
    );
  }
}
