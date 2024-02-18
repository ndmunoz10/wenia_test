import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wenia_test/presentation/ui/styles/text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.statefulNavigationShell, super.key});

  final StatefulNavigationShell statefulNavigationShell;

  @override
  Widget build(BuildContext context) {
    const cryptsTab = BottomNavigationBarItem(
      icon: Icon(
        Icons.monetization_on,
        color: Colors.white,
      ),
      label: 'Crypts',
    );
    const favsTab = BottomNavigationBarItem(
      icon: Icon(
        Icons.favorite_rounded,
        color: Colors.white,
      ),
      label: 'Favs',
    );
    const vsTab = BottomNavigationBarItem(
      icon: Icon(
        Icons.compare_arrows_rounded,
        color: Colors.white,
      ),
      label: 'Vs',
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: statefulNavigationShell),
      // ignore: use_decorated_box
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        showUnselectedLabels: true,
        selectedLabelStyle: bodyTextStyle.copyWith(fontSize: 14),
        unselectedLabelStyle: bodyTextStyle.copyWith(fontSize: 14),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: statefulNavigationShell.currentIndex,
        onTap: statefulNavigationShell.goBranch,
        type: BottomNavigationBarType.fixed,
        items: const [cryptsTab, favsTab, vsTab],
      ),
    );
  }
}
