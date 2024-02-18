import 'package:flutter/material.dart';
import 'package:wenia_test/presentation/ui/styles/text_styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Crypt\nMade Easier',
          style: titleTextStyle.copyWith(fontSize: 40),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
