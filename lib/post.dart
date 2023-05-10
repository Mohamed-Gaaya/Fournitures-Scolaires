import 'dart:convert';
import 'dart:io';

import 'package:face_net_authentication/pages/chat.dart';
import 'package:face_net_authentication/pages/db/databse_helper.dart';
import 'package:face_net_authentication/pages/my_posts.dart';
import 'package:face_net_authentication/pages/profile.dart';
import 'package:face_net_authentication/personal_info.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class PostArticlePage extends StatefulWidget {
  const PostArticlePage(this.username,
      {Key? key, required this.imagePath, required this.id})
      : super(key: key);
  final String username;
  final String imagePath;
  final int id;
  @override
  _PostArticlePageState createState() => _PostArticlePageState(
      username: this.username, imagePath: this.imagePath, id: this.id);
}

class _PostArticlePageState extends State<PostArticlePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  _PostArticlePageState(
      {required this.username, required this.imagePath, required this.id});
  final String username;
  final String imagePath;
  final int id;

  List<String> images = [];
  XFile? imageupload;
  var isloading = false;
  Future<void> chooseImage() async {
    final ImagePicker pick = new ImagePicker();
    XFile? choosedimage = await pick.pickImage(source: ImageSource.gallery);
    List<int> imageBytes = (await choosedimage?.readAsBytes()) as List<int>;
    String baseimage = base64Encode(imageBytes);
    final List<String> imagat = images;
    imagat.add(baseimage);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      images = imagat;
    });
  }

  Future<void> chooseImagecamera() async {
    final ImagePicker pick = new ImagePicker();
    XFile? choosedimage = await pick.pickImage(source: ImageSource.camera);
    List<int> imageBytes = (await choosedimage?.readAsBytes()) as List<int>;
    String baseimage = base64Encode(imageBytes);
    final List<String> imagat = images;
    imagat.add(baseimage);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      images = imagat;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black87,
        showUnselectedLabels: true,
        //backgroundColor: Colors.blueGrey[500],
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
              onPressed: () {},
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
      body: isloading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                  ),
                ),
              ],
            )
          : Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    Text(
                      ' Post Article here !',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 48, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.blueGrey,
                        ),
                        labelText: 'Title',
                        labelStyle: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _priceController,
                      decoration: InputDecoration(
                        labelText: 'Price',
                        suffixText: 'TND',
                        labelStyle: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: ElevatedButton(
                                onPressed: () async {
                                  await chooseImage();
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blueGrey),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                                child: Icon(
                                  Icons.cloud_upload,
                                  size: 36.0,
                                ),
                              ),
                            ),
                            Center(
                              child: ElevatedButton(
                                onPressed: () async {
                                  await chooseImagecamera();
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blueGrey),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 36.0,
                                ),
                              ),
                            )
                          ]),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: GridView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: Image.memory(base64Decode(images[index])),
                            );
                          },
                          itemCount: images.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // number of columns
                            crossAxisSpacing: 0, // space between columns
                            mainAxisSpacing: 10, // space between rows
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        onPressed: () async {
                          final title = _titleController.text;
                          final description = _descriptionController.text;
                          final price = double.parse(_priceController.text);
                          // TODO: Save the article to the database or post it to the server.

                          final prod = new Prod(
                              id: 1,
                              title: title,
                              description: description,
                              price: price,
                              images: images);
                          setState(() {
                            isloading = true;
                          });
                          await insertproduct(prod);
                          setState(() {
                            isloading = false;
                          });

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
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blueGrey),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            'Post Article',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
