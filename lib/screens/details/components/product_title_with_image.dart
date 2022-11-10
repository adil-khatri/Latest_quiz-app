import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/Product.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center ,
        children: <Widget>[
          Text(
            product.title,
            style: Theme.of(context)
                .textTheme
                .headline5?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: kDefaultPaddin /2,)
        ],
      ),
    );
  }
}
