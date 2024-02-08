
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../model/producr_model.dart';


class ProductTile extends StatelessWidget {
  final Products product;
  ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        Expanded(
          child: Container(
            height: 180,
            width: double.infinity,
            child: CachedNetworkImage(imageUrl: product.image!,fit: BoxFit.cover,),
          ),
        ),
        const SizedBox(height: 10,),
        Text(product.title!,maxLines: 2,),
        const SizedBox(height: 10,),
        Text("${product.price}"),
        const SizedBox(height: 10,),
        Text("${product.rating?.rate!}")],),

    );
  }
}