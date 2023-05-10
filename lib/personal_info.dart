import 'dart:io';

import 'package:face_net_authentication/pages/chat.dart';
import 'package:face_net_authentication/pages/db/databse_helper.dart';
import 'package:face_net_authentication/pages/home.dart';
import 'package:face_net_authentication/pages/my_posts.dart';
import 'package:face_net_authentication/pages/profile.dart';
import 'package:face_net_authentication/pages/update_profile.dart';
import 'package:face_net_authentication/pages/widgets/app_button.dart';
import 'package:face_net_authentication/post.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage(this.username,
      {Key? key, required this.imagePath, required this.id})
      : super(key: key);
  final int id;
  final String username;
  final String imagePath;

  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState(
      username: this.username, imagePath: this.imagePath, id: this.id);
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  //String username = "";

  _PersonalInfoPageState(
      {required this.username, required this.imagePath, required this.id});
  final String username;
  final String imagePath;
  final int id;
  MyModel? usera;
  String firstname = "";
  String lastname = "";
  String email = "";
  String phonenumber = "";
  String password = "";
  String confirmpassword = "";
  Future<void> getuser() async {
    usera = await fetchuser(id);
    print(usera);
    if (usera!.PhoneNumber != null) {
      setState(() {
        phonenumber = usera!.PhoneNumber as String;
      });
    }
    if (usera!.FirstName != null) {
      setState(() {
        firstname = usera!.FirstName as String;
      });
    }
    if (usera!.LastName != null) {
      setState(() {
        lastname = usera!.LastName as String;
      });
    }
  }

  @override
  void initState() {
    getuser();
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
                //function here
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: ListView(
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
                                builder: (context) => ProfilePictureWidget(
                                      imagePath: imagePath,
                                      username: username,
                                      currentImagePath: '',
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
              SizedBox(height: 0),
              Text(
                ' Update Profile Here !',
                style:
                    GoogleFonts.bebasNeue(fontSize: 48, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 0),
              Text(
                ' Please update your Personal information',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              //first name textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.black87),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextFormField(
                      initialValue: firstname,
                      //controller: _firstNameController,
                      cursorColor: Colors.black87,
                      style: TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'First Name',
                        hintStyle: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              //last name textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.black87),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      //controller: _lastnameController,
                      cursorColor: Colors.black87,
                      style: TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Last Name',
                        hintStyle: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              //last name textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.black87),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      //controller: _usernameController,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: username,
                        hintStyle: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              //phone textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.black87),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: IntlPhoneField(
                      initialValue: phonenumber,
                      //controller: _phoneController,
                      cursorColor: Colors.black87,
                      style: TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.blueAccent),
                        labelStyle: TextStyle(color: Colors.black87),
                        border: InputBorder.none,
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                        ),
                      ),
                      textAlign: TextAlign.start,
                      initialCountryCode: 'TN',
                      flagsButtonMargin: EdgeInsets.symmetric(horizontal: 2.0),
                      dropdownTextStyle:
                          TextStyle(color: Colors.black87, fontSize: 17),
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: 8),

              //email textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.black87),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextFormField(
                      initialValue: email,
                      //controller: _emailController,
                      cursorColor: Colors.black87,
                      style: TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              //password textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.black87),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      //controller: _passwordController,
                      obscureText: true,
                      cursorColor: Colors.black87,
                      style: TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'New Password',
                        hintStyle: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              //confirm password textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.black87),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      //controller: _confirmpasswordController,
                      obscureText: true,
                      cursorColor: Colors.black87,
                      style: TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 8),

              //sign up button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () async {},
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(top: 50),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                child: AppButton(
                  text: "LOG OUT",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  color: Color(0xFFFF6161),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
