import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const SplashContent(
      {Key? key,
      required this.image,
      required this.title,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!;
    final TextStyle headline6 = Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.w400);
    return Container(
      child: Column(
        children: [
          Image.asset(image,height: 196,fit: BoxFit.cover,),
          const SizedBox(height: 40),
          Text(title,
              style: headline4.copyWith(color: Theme.of(context).primaryColor)),
          const SizedBox(height: 10),
          Text(subtitle,
              style: headline6.copyWith(
                  color: Theme.of(context).primaryColor)),
        ],
      ),
    );
  }
}
