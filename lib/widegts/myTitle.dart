import 'package:flutter/material.dart';

class MyTitleWidget extends StatelessWidget {
  final String title;
  const MyTitleWidget({required this.title ,super.key});

  @override
  Widget build(BuildContext context) {
    return   Text(
                    title,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  );
  }
}
