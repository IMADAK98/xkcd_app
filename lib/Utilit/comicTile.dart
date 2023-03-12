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
    return ListTile(
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
    );
  }
}
