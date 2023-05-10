import 'dart:io';

import 'package:face_net_authentication/pages/chat.dart';
import 'package:face_net_authentication/pages/my_posts.dart';
import 'package:face_net_authentication/personal_info.dart';
import 'package:face_net_authentication/post.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../single_post.dart';
import 'db/databse_helper.dart';

class Profile extends StatefulWidget {
  final id;

  const Profile(this.username,
      {Key? key, required this.imagePath, required this.id})
      : super(key: key);
  final String username;
  final String imagePath;

  @override
  Profilestate createState() => Profilestate(
      username: this.username, imagePath: this.imagePath, id: this.id);
}

class Profilestate extends State<Profile> {
  Profilestate({
    required this.username,
    required this.imagePath,
    required this.id,
  });
  final String username;
  final String imagePath;
  final int id;

  List<Prod> posts = [];
  void _getProds() async {
    List<Prod> prods = await fetch();
    setState(() {
      posts = prods;
      print(prods);
    });
  }

  @override
  void initState() {
    _getProds();
  }

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
                // Your function here
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
                            id: id,
                            imagePath: imagePath,
                          )),
                );
              },
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(FontAwesomeIcons.cartShopping),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ArticleListWidget(
                            username,
                            imagePath: imagePath,
                            id: id,
                          )),
                );
              },
            ),
            label: 'My Posts',
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Container(
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
                                        id: id,
                                        imagePath: imagePath,
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
                                      imagePath: imagePath,
                                      id: id,
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
                SizedBox(
                  width: 380.0,
                  child: Card(
                    elevation: 4.0,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 4.0),
                      child: TextFormField(
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(color: Colors.blueGrey),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            FontAwesomeIcons.magnifyingGlass,
                            color: Colors.black,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: Colors.grey,
                            ),
                            onPressed: () => {},
                          ),
                        ),
                        //onFieldSubmitted: controlSearching,
                      ),
                    ),
                  ),
                ),
                //Spacer(),
                Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4.0,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          title: Text(
                            posts[index].title,
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                posts[index].description,
                                style: TextStyle(fontSize: 16.0),
                              ),
                              SizedBox(height: 10.0),
                              if (posts[index].images != null)
                                GridView.count(
                                  shrinkWrap: true,
                                  crossAxisCount: 3,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                  children: [
                                    for (String image in posts[index].images)
                                      Image.network(
                                        "https://flutterprogayya.000webhostapp.com/$image",
                                        fit: BoxFit.cover,
                                      ),
                                  ],
                                ),
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ArticleDetails(
                                  title: posts[index].title,
                                  description: posts[index].description,
                                  price: posts[index].price,
                                  images: posts[index].images,
                                  imagePath: imagePath,
                                  username: username,
                                  id: id,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//controlSearching(String userName) {
//Future<QuerySnapchot> allUsers =
//}
