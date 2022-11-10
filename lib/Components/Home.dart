import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_kjs/Components/Authentication.dart';
import 'package:quiz_app_kjs/screens/create_quiz.dart';
import 'package:quiz_app_kjs/screens/home/components/body.dart';


class DrawerLabel extends StatefulWidget {
  final String text;
  final Icon icon;
  final void Function() onTap;
  final String? email;
  DrawerLabel(
      {required this.text,
        required this.icon,
        required this.onTap,
        this.email});

  @override
  _DrawerLabelState createState() => _DrawerLabelState();
}

class _DrawerLabelState extends State<DrawerLabel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          ListTile(
            onTap: widget.onTap,
            leading: widget.icon,
            title: Text(
              widget.text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  get user1 => _firebaseAuth.currentUser;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseAuthService>(context).currentUser();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz App'),
        ),
        drawer: Drawer(
          child: Material(
            color: Theme.of(context).primaryColor,
            child: ListView(padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(user1!.displayName.toString()),
                    accountEmail: Text(user1!.email.toString()),
                    currentAccountPicture: user1.photoURL != null
                        ? ClipOval(
                      child: Material(
                        elevation: 2.0,
                        shadowColor: Colors.black,
                        color: Colors.grey.shade600,
                        child: Image.network(
                          user1.photoURL!,
                          width: 60.0,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    )
                        : ClipOval(
                      child: Material(
                        // color: CustomColors.firebaseGrey.withOpacity(0.3),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  DrawerLabel(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    text: "Home",
                    onTap: () {  },
                  ),
                  DrawerLabel(
                    icon: Icon(
                      Icons.add_sharp,
                      color: Colors.white,
                    ),
                    text: "History",
                    onTap: () {  },
                  ),
                  DrawerLabel(
                    icon: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    text: "Logout",
                    onTap: () {
                      try {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Logout"),
                                content: Text("Do you really want to logout ?"),
                                actions: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                    // ignore: deprecated_member_use
                                    child: TextButton(
                                      child: Text("Yes"),
                                      onPressed: () {
                                        _firebaseAuth.signOut();
                                        Navigator.pushNamedAndRemoveUntil(context,
                                            "/", (Route<dynamic> route) => false);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                    // ignore: deprecated_member_use
                                    child: TextButton(
                                      child: Text("No"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ],
                              );
                            });
                      } catch (e) {
                        print(e);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Logout Error"),
                              content: Text(
                                  "Some error occurred!\nYou are still Logged In"),
                              actions: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  // ignore: deprecated_member_use
                                  child: TextButton(
                                    child: Text("Try Again"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  )
                ]),
          ),
        ),
        body: Body(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.orange,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreateQuiz()));
          },
        ));
  }
}