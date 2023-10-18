import 'package:flutter/material.dart';


class ContentIntro extends StatelessWidget {
  final String aboutHouse;
  final String price;
  final String houseLocation;
  final String rentOrSale;
  const ContentIntro(
      {Key? key,
      required this.aboutHouse,
      required this.price,
      required this.houseLocation,
      required this.rentOrSale})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(aboutHouse,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        const SizedBox(height: 2.5),
        Text(houseLocation, style: Theme.of(context).textTheme.bodyMedium),
        // const SizedBox(height: 5),
        // Text(
        //   house.size,
        //   style: Theme.of(context).textTheme.bodyText2,
        // ),
        const SizedBox(height: 5),
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: ('M$price' ' ' '$rentOrSale'),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ]))
      ]),
    );
  }
}
