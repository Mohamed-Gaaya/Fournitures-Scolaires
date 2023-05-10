import 'dart:io';

import 'package:face_net_authentication/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../personal_info.dart';
import '../post.dart';
import 'my_posts.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(this.username,
      {Key? key, required this.imagePath, required this.id})
      : super(key: key);
  final String username;
  final String imagePath;
  final int id;
  @override
  _ChatScreenState createState() => _ChatScreenState(
      username: this.username, imagePath: this.imagePath, id: this.id);
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _textEditingController = TextEditingController();

  _ChatScreenState({
    required this.username,
    required this.imagePath,
    required this.id,
  });
  final String username;
  final String imagePath;
  final int id;

  List<ChatMessage> _messages = <ChatMessage>[];

  void _handleSubmitted(String text) {
    _textEditingController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
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
                      builder: (context) =>
                          Profile(username, imagePath: imagePath, id: id)),
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
        child: Column(
          children: <Widget>[
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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
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
            Flexible(
              child: ListView.builder(
                reverse: true,
                padding: EdgeInsets.all(8.0),
                itemCount: _messages.length,
                itemBuilder: (_, int index) => _messages[index],
              ),
            ),
            Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.insert_emoticon),
              onPressed: () {
                // TODO: Handle emoji button press
              },
            ),
            IconButton(
              icon: Icon(Icons.photo),
              onPressed: () {
                // TODO: Handle photo button press
              },
            ),
            Flexible(
              child: TextField(
                controller: _textEditingController,
                onSubmitted: _handleSubmitted,
                decoration:
                    InputDecoration.collapsed(hintText: 'Send a message'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textEditingController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({required this.text, required this.animationController});

  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                child: Text('JM'),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('John Doe',
                      style: Theme.of(context).textTheme.headline6),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: Text(text),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
