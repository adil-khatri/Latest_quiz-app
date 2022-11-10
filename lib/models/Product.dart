import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_kjs/services/database.dart';


String dummyText = "Computer networking";
class Product {
  final String image, title, description, id;
  final int size;
  final Color color;
  Product({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.size,
    required this.color,
  });
}

class tp extends StatelessWidget {
  const tp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

late Stream quizStream;
DatabaseService databaseService = new DatabaseService();
Widget quizList() {
  return Container(
    // margin: EdgeInsets.symmetric(horizontal: 24),
    child: StreamBuilder(
      stream: FirebaseFirestore.instance.collection("quiz").snapshots(),
      builder:
          (__, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        print("yYyyyyyyyyyyyyeeeeeeeeeeeeeeesssssssssss");
        if (snapshot.hasData && snapshot.data != null) {
          print("Total Docs :----- ${snapshot.data!.docs.length}");
          if (snapshot.data!.docs.isNotEmpty) {
            return ListView.separated(
                itemBuilder: (___, int index) {
                  Map<String, dynamic> docData =
                      snapshot.data!.docs[index].data();

                  if (docData.isEmpty) {
                    return Text("Document is empty");
                  }
                  String tittle =
                      snapshot.data!.docs.elementAt(index).get("quizTitle");
                  String imgUrl =
                      snapshot.data!.docs.elementAt(index).get("quizImgUrl");
                  String desc =
                      snapshot.data!.docs.elementAt(index).get("quizDesc");
                  String quizId =
                      snapshot.data!.docs.elementAt(index).get("quizId");

                  print(" Thisss isss tittlllee${tittle}");
                  // Product p1 = new Product();
                  // List<Product> products = [
                  //   Product(
                  //       id: quizId,
                  //       image: imgUrl,
                  //       title: title,
                  //       description: desc,
                  //       size: 12,
                  //       color: Colors.blue.shade400)
                  // ];
                  return Container();
                  // QuizTile(
                  //   imgUrl: imgUrl,
                  //   title: title,
                  //   desc: desc,
                  //   quizId: quizId,
                  // );
                  // ListTile(
                  //   title: Text(title),
                  //   subtitle: Text(desc),
                  // );
                },
                separatorBuilder: (___, ____) {
                  return Divider();
                },
                itemCount: snapshot.data!.docs.length);
          } else {
            return Center(child: Text("Documents arent available"));
          }
        } else {
          return Center(child: Text("Getting Error"));
        }
      },
    ),
  );
}

// Map<String, String> products = {
//   "quizId": quizId,
//   "quizImgUrl": quizImgUrl,
//   "quizTitle": quizTitle,
//   "quizDesc": quizDesc
// };

List<Product> products = [
  Product(
      id: "1",
      title: "Data Warehousing",
      size: 12,
      description: "Data warehousing is a method of organizing and compiling data into one database, whereas data mining deals with fetching important data ",
      image: "assets/images/dwm.png",
      color: Colors.blue.shade400),
  Product(
      id: "2",
      title: "Computer Network",
      size: 12,
      description: "Computer networking refers to interconnected computing devices that can exchange data and share resources with each other",
      image: "assets/images/cn.png",
      color: Colors.blue.shade400),
  Product(
      id: "3",
      title: "Internet Programming",
      size: 12,
      description: "An Internet application is a client-server application that uses standard Internet protocols for connecting the client to the server.",
      image: "assets/images/ip.png",
      color: Colors.blue.shade400
  ),

  Product(
      id: "4",
      title: "Software Engineering",
      size: 12,
      description: "Software engineering is defined as a process of analyzing user requirements and then designing, building, and testing software application",
      image: "assets/images/se.png",
      color: Colors.blue.shade400),
  Product(
      id: "5",
      title: "Theory Of Computer Science",
      size: 12,
      description: "",
      image: "assets/images/tcs.png",
      color: Colors.blue.shade400),
  Product(
      id: "5",
      title: "State Based Learning",
      size: 12,
      description: "",
      image: "assets/images/sbl.png",
      color: Colors.blue.shade400),
];
