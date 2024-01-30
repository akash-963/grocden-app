import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/product_model.dart';
import '../shop_image.dart';


class ProductTile extends StatelessWidget{
  final Product product;
  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return VxBox(
        child: Row(
          children: [
            Hero(
                tag: Key(product.id.toString()),
                child: ShopImage(image: product.image)),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    product.name.text.lg.color(context.accentColor).bold.make(),
                    product.desc.text.make(),
                    10.heightBox,
                    ButtonBar(
                        alignment: MainAxisAlignment.spaceBetween,
                        buttonPadding: EdgeInsets.zero,
                        children: [
                          "\$${product.price}".text.xl.bold.make(),
                          _AddToCart(product: product)
                        ]
                    ).pOnly(right: 16)
                  ],
                )
            )
          ],
        )

    ).color(context.cardColor).roundedLg.square(130).make().py8();
  }

}

class _AddToCart extends StatefulWidget {
  final Product product;

  const _AddToCart({
    super.key, required this.product,
  });

  @override
  State<_AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<_AddToCart> {
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xff403b58)),
            shape: MaterialStateProperty.all(
              StadiumBorder(),
            )
        ),
        onPressed: () {
          final _catalog = ProductModel();
          //final _cart = CartModel();
          //_cart.catalog = _catalog;
          isAdded = isAdded.toggle();
          //_cart.add(widget.catalog);
          setState(() {

          });
        },
        child: isAdded ? Icon(Icons.done) :"Add to Cart".text.make()
    );
  }
}