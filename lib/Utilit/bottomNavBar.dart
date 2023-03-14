import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:xkcd_app/pages/comicPage.dart';
import 'package:xkcd_app/pages/selectionPage.dart';

import '../pages/homeScreen.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

int BottomNavIndex = 0;

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
        color: Colors.deepOrange.shade200,
      ),
      child: BottomNavigationBar(
        fixedColor: Colors.black,
        backgroundColor: Colors.deepOrange.shade200,
        elevation: 0,
        showUnselectedLabels: false,
        currentIndex: BottomNavIndex,
        onTap: (value) {
          setState(() {
            switch (value) {
              case 0:
                if (value == 0) {
                  BottomNavIndex = 0;
                  Navigator.pushReplacementNamed(context, "/");
                }
                break;
              case 1:
                if (value == 1) {
                  BottomNavIndex = 1;
                  Navigator.pushReplacementNamed(context, "/searchPage");
                }
                break;
              case 2:
                if (value == 2) {
                  BottomNavIndex = 2;
                  Navigator.pushNamed(context, "/starred");
                }
            }
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_download_done),
            label: "downloaded",
          )
        ],
      ),
    );
  }
}
