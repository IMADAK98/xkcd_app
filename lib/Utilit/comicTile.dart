import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../pages/comicPage.dart';

class ComicTile extends StatelessWidget {
  ComicTile({super.key, required this.comic});
  final Map<String, dynamic> comic;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => ComicPage(comic: comic))),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(8),
              child: Image.file(
                File(comic["img"]),
                fit: BoxFit.fill,
                width: 120,
                height: 120,
              ),
            ),
            Text(comic["title"],
                style: const TextStyle(
                  fontSize: 15,
                ))
          ],
        ),
      ),
    );
  }
}
/*ListTile(
      leading: Image.file(File(comic["img"])),
      title: Text(comic["title"]),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ComicPage(
                      comic: comic,
                    )));
      },
    )*/