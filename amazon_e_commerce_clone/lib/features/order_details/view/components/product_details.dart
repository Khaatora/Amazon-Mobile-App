import 'package:amazon_e_commerce_clone/core/features/home/model/product_model.dart';
import 'package:amazon_e_commerce_clone/core/global/size_config.dart';
import 'package:flutter/material.dart';

import '../../../../core/global/components/reusable_components/slidable_zoomable_gallery_widget.dart';

class OrdersProductDetails extends StatelessWidget {
  const OrdersProductDetails(
      {super.key, required this.product, required this.quantity});

  final Product product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    double avgRating = 0.0;
    if (product.ratings != null && product.ratings!.isNotEmpty) {
      double sumRating = 0.0;
      for (var rating in product.ratings!) {
        sumRating += rating.rating ?? 0.0;
      }
      avgRating = sumRating / (product.ratings!.length);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Table(
          columnWidths: const {
            1: FlexColumnWidth(1.5),
          },
          children: [
            TableRow(children: [
              const TableCell(
                child: Text("Name: "),
              ),
              TableCell(child: Text(product.name))
            ]),
            TableRow(children: [
              const TableCell(
                child: Text("ID: "),
              ),
              TableCell(child: Text(product.id!))
            ]),
            TableRow(children: [
              const TableCell(
                child: Text("Total Price: "),
              ),
              TableCell(child: Text("\$${product.price.toString()}"))
            ]),
            TableRow(children: [
              const TableCell(
                child: Text("Quantity: "),
              ),
              TableCell(child: Text(product.quantity.toString()))
            ]),
            TableRow(children: [
              const TableCell(
                child: Text("Rating: "),
              ),
              TableCell(child: Text("$avgRating/5.0"))
            ]),
            TableRow(children: [
              const TableCell(
                child: Text("Description: "),
              ),
              TableCell(child: Text(product.description))
            ]),
          ],
        ),
        SlidableZoomableGalleryWidget(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            widgetWidth: SizeConfig.safeScreenWidth,
            imageWidth: SizeConfig.safeScreenWidth,
            images: product.images),
      ],
    );
  }
}
