import 'package:flutter/material.dart';

class DealOfTheDayWidget extends StatelessWidget {
  const DealOfTheDayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10, top: 15),
          child: const Text(
            "Deal of the day",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
        Image.network(
          "https://plus.unsplash.com/premium_photo-1686514714138-51925a219605?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60",
          height: 232,
          fit: BoxFit.fitHeight,
        ),
        Container(
          padding: const EdgeInsets.only(left: 16,),
          alignment: Alignment.topLeft,
          child: const Text("Price: 50\$", maxLines: 2, overflow: TextOverflow.ellipsis,style: const TextStyle(
            fontSize: 18,
            
          ),),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, top: 6, right: 40),
          alignment: Alignment.topLeft,
          child: Text("Bruh", maxLines: 2, overflow: TextOverflow.ellipsis,),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network("https://plus.unsplash.com/premium_photo-1686514714138-51925a219605?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60", fit: BoxFit.fitWidth, width: 100, height: 100,),
              Image.network("https://plus.unsplash.com/premium_photo-1686514714138-51925a219605?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60", fit: BoxFit.fitWidth, width: 100, height: 100,),
              Image.network("https://plus.unsplash.com/premium_photo-1686514714138-51925a219605?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60", fit: BoxFit.fitWidth, width: 100, height: 100,),
              Image.network("https://plus.unsplash.com/premium_photo-1686514714138-51925a219605?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60", fit: BoxFit.fitWidth, width: 100, height: 100,),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, bottom: 16, top: 16),
          alignment: Alignment.topLeft,
          child: Text("See all deals", style: TextStyle(
            color: Colors.cyan[800],

          ),),
        )
      ],
    );
  }
}
