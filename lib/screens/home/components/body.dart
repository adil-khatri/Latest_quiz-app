import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_kjs/constants.dart';
import 'package:quiz_app_kjs/models/Product.dart';
import 'package:quiz_app_kjs/screens/details/details_screen.dart';
import 'package:quiz_app_kjs/services/database.dart';

import 'categorries.dart';
import 'item_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  late Stream quizStream;
  DatabaseService databaseService = new DatabaseService();
  Widget quizList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("quiz").snapshots(),
        builder:
            (__, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          print("WWWwwwwwwwwwwoorkingggggggggggg");
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
          child: Text(
            "Topics",
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        //later delete category
        Categories(),
        quizList(),
        // Home(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ItemCard(
                      product: products[index],
                      press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              product: products[index],
                            ),
                          )),
                    )),
          ),
        ),
      ],
    );
  }
}


//Start of CLASs ITEM CARD



