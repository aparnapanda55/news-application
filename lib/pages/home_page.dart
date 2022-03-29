import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_application2/models/newsmodel.dart';
import 'package:news_application2/services/api_manager.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<NewsModel>(
        future: ApiManager().getNews(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return ListView.builder(
            itemCount: snapshot.data.articles.length,
            itemBuilder: (BuildContext context, int index) {
              var article = snapshot.data.articles[index];
              return ListTile(
                leading: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 10,
                  child: Image.network(article.urlToImage),
                ),
                title: Text(
                  article.title,
                  style: TextStyle(fontSize: 14),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) =>
                            Description(text: article.description)),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Description extends StatelessWidget {
  const Description({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              text.replaceAll('<ol><li>', ' '),
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
