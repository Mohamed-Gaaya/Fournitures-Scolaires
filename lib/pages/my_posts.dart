import 'dart:io';

import 'package:face_net_authentication/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../personal_info.dart';
import '../post.dart';
import 'chat.dart';

// Model for Article
class Article {
  final String title;
  final String description;
  final double price;

  Article({
    required this.title,
    required this.description,
    required this.price,
  });
}

class ArticleListWidget extends StatefulWidget {
  const ArticleListWidget(this.username,
      {Key? key, required this.imagePath, required this.id})
      : super(key: key);
  final String username;
  final String imagePath;
  final int id;
  @override
  _ArticleListWidgetState createState() => _ArticleListWidgetState(
      username: this.username, imagePath: this.imagePath, id: this.id);
}

class _ArticleListWidgetState extends State<ArticleListWidget> {
  _ArticleListWidgetState({
    required this.username,
    required this.imagePath,
    required this.id,
  });
  final String username;
  final String imagePath;
  final int id;
  List<Article> _articles = [
    Article(
      title: "Article 1",
      description: "Description for Article 1",
      price: 9.99,
    ),
    Article(
      title: "Article 2",
      description: "Description for Article 2",
      price: 19.99,
    ),
    Article(
      title: "Article 3",
      description: "Description for Article 3",
      price: 29.99,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black87,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        selectedItemColor: Colors.black87,
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.home_rounded),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Profile(
                            username,
                            imagePath: imagePath,
                            id: id,
                          )),
                );
              },
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.add_box),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PostArticlePage(
                            username,
                            imagePath: imagePath,
                            id: id,
                          )),
                );
              },
            ),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(FontAwesomeIcons.circleUser),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PersonalInfoPage(
                            username,
                            imagePath: imagePath,
                            id: id,
                          )),
                );
              },
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(FontAwesomeIcons.cartShopping),
              onPressed: () {},
            ),
            label: 'My Posts',
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Card(
            elevation: 4.0,
            child: Column(
              children: [
                Card(
                  elevation: 4.0,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(File(imagePath)),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PersonalInfoPage(
                                        username,
                                        imagePath: imagePath,
                                        id: id,
                                      )),
                            );
                          },
                        ),
                        margin: EdgeInsets.all(20),
                        width: 50,
                        height: 50,
                      ),
                      Text(
                        'Hi ' + username + ' !',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                      username,
                                      id: id,
                                      imagePath: imagePath,
                                    )),
                          );
                        },
                        icon: Icon(
                          FontAwesomeIcons.facebookMessenger,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 4.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.post_add, size: 28.0),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'My Posts',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _articles.length,
                    itemBuilder: (context, index) {
                      final article = _articles[index];
                      return Card(
                        elevation: 4.0,
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    article.title,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                article.description,
                                style: TextStyle(fontSize: 16.0),
                              ),
                              SizedBox(height: 16.0),
                              Text(
                                '\$${article.price}',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  elevation: 4.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_rounded,
                          size: 28.0, color: Colors.red),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'My Favorites',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _articles.length,
                    itemBuilder: (context, index) {
                      final article = _articles[index];
                      //if (!article.isFavorite) {
                      //return SizedBox.shrink();
                      // }
                      return Card(
                        elevation: 4.0,
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    article.title,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.favorite_rounded,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                article.description,
                                style: TextStyle(fontSize: 16.0),
                              ),
                              SizedBox(height: 16.0),
                              Text(
                                '\$${article.price}',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
