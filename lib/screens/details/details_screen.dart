import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiz_app_kjs/constants.dart';
import '../../models/Product.dart';
import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;

  const DetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // for eac product color
        backgroundColor: product.color,
      appBar: buildAppBar(context),
      body: Body(product: product),
    );

  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: product.color,
      elevation: 0,
        // leading: IconButton
        //   (
        //   icon: SvgPicture.asset(
        //   'assets/icons/back.svg',
        //    color: Colors.black,
        // ),
        //   onPressed: () => Navigator.pop(context),
        // ),
      // actions: <Widget>[
      //   IconButton(icon: SvgPicture.asset("assets/icons/search.svg"),
      //   onPressed: (){},
      //   ),
      //   IconButton(icon: SvgPicture.asset("assets/icons/cart.svg"),
      //   onPressed: (){},
      //   ),
      //   SizedBox(
      //     width: kDefaultPaddin/2,
      //   ),
    );
  }
}