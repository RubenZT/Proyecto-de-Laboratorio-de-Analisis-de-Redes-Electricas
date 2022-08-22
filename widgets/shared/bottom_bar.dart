import 'package:community_material_icon/community_material_icon.dart';
import 'package:plug/pages/home.dart';
import 'package:plug/pages/report.dart';
import 'package:plug/pages/results.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;

  const BottomBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.indigo,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white38,
      onTap: (i) {
        if (i == currentIndex) return;

        Widget page;
        switch (i) {
          case 0:
            page = const Results();
            break;
          case 2:
            page = const Report();
            break;
          default:
            page = const Home();
            break;
        }
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => page), (_) => false);
      },
      items: [
        const BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.all(4),
            child: Icon(CommunityMaterialIcons.clipboard_text),
          ),
          label: 'Results',
        ),
        BottomNavigationBarItem(
          icon: const Padding(
            padding: EdgeInsets.all(4),
            child: Icon(CommunityMaterialIcons.home_variant),
          ),
          activeIcon: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              CommunityMaterialIcons.home_variant,
              color: Colors.indigo,
            ),
          ),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.all(4),
            child: Icon(Icons.pie_chart),
          ),
          label: 'Report',
        ),
      ],
    );
  }
}
