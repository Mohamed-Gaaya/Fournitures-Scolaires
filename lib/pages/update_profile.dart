import 'dart:io';

import 'package:face_net_authentication/pages/db/databse_helper.dart';
import 'package:face_net_authentication/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../personal_info.dart';
import '../post.dart';
import 'chat.dart';
import 'my_posts.dart';

class ProfilePictureWidget extends StatefulWidget {
  final String username;
  final String imagePath;
  final String currentImagePath;
  final int id;

  const ProfilePictureWidget(
      {required this.username,
      required this.imagePath,
      required this.currentImagePath,
      required this.id});

  @override
  _ProfilePictureWidgetState createState() => _ProfilePictureWidgetState(
      username: this.username, imagePath: this.imagePath, id: this.id);
}

class _ProfilePictureWidgetState extends State<ProfilePictureWidget> {
  _ProfilePictureWidgetState(
      {required this.username, required this.imagePath, required this.id});
  final String username;
  final String imagePath;
  final ImagePicker _picker = ImagePicker();
  late File _imageFile;
  int _selectedIndex = 0;
  final int id;

  @override
  void initState() {
    super.initState();
    _imageFile = File(widget.imagePath);
    print(fetchuser(id));
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 56.0,
                  child: ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Photo Library'),
                    onTap: () {
                      _getImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Container(
                  height: 56.0,
                  child: ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      _getImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
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
              Expanded(
                child: SafeArea(
                  child: Center(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showPicker(context);
                            },
                            child: CircleAvatar(
                              radius: 150.0,
                              backgroundImage: FileImage(_imageFile),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          ElevatedButton(
                            onPressed: () {
                              //TODO: implement profile picture update logic
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.blueGrey,
                              ),
                            ),
                            child: Text('Update Profile Picture'),
                          ),
                        ],
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
