import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({required this.imgLink, Key? key}) : super(key: key);

  final String imgLink;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      color: Colors.white,
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(5)),
        child: Container(
          width: 180,
          padding: const EdgeInsets.all(10),
          child: Image.network(
            imgLink,
            fit: BoxFit.fitHeight,
            width: 180,
          ),
        ),
      ),
    );
  }
}
