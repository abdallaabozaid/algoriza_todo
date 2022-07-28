import 'package:flutter/material.dart';

class GoBackIcon extends StatelessWidget {
  const GoBackIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(
        Icons.arrow_back_ios,
        size: 18,
      ),
    );
  }
}
