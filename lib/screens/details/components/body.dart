import 'package:flutter/material.dart';
import 'package:quiz_app_kjs/constants.dart';
import 'package:quiz_app_kjs/models/Product.dart';
import 'package:quiz_app_kjs/quiz/quiz_screen.dart';

import 'description.dart';
import 'product_title_with_image.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //it is for total height and width
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: size.height * 0.3),
                    padding: EdgeInsets.only(
                      top: size.height * 0.12,
                      left: kDefaultPaddin,
                      right: kDefaultPaddin,
                    ),
                    // height: 500,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        )),
                    child:
                            Column(
                              children: <Widget>[
                                Text("Description"),
                                Description(product: product),
                              ],
                            )

                    ),
                ProductTitleWithImage(product: product),
                SizedBox(
                  width: kDefaultPaddin,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 450.0),
                  child: Center(
                    child: Expanded(
                        child: Image.asset(
                      product.image,
                      width: 250,
                      height: 250,
                      scale: 0.1,
                      alignment: Alignment.bottomLeft,
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 320.0, 0.0, 0.0),
                  child: Center(
                    heightFactor: 150,
                    child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          child: const Text('Start Quiz',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => QuizScreen()),
                            );
                          },
                        ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
