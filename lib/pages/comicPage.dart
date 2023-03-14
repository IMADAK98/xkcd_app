import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xkcd_app/Utilit/bottomNavBar.dart';

class ComicPage extends StatefulWidget {
  ComicPage({super.key, required this.comic});
  final Map<String, dynamic> comic;
  late var docsDir;

  @override
  State<ComicPage> createState() => _ComicPageState();
}

class _ComicPageState extends State<ComicPage> {
  void _launchComic(int comicNumber) {
    launchUrl(Uri.parse("https://xkcd.com/$comicNumber"));
    debugPrint(widget.comic["img"]);
  }

  late bool isStarred = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApplicationDocumentsDirectory().then((dir) {
      widget.docsDir = dir.path;
      var file = File("${widget.docsDir}/starred");
      if (!file.existsSync()) {
        file.createSync();
        file.writeAsStringSync("[]");
        isStarred = false;
      } else {
        setState(() {
          isStarred = _isStarred(widget.comic["num"]);
        });
      }
    });
  }

  void _addToStarred(int num) {
    var file = File('${widget.docsDir}/starred');
    List<int> savedComics = jsonDecode(file.readAsStringSync()).cast<int>();
    if (isStarred) {
      savedComics.remove(num);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Removed successfully!")));
    } else {
      savedComics.add(num);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Added successfully!")));
    }
    file.writeAsStringSync(json.encode(savedComics));
  }

  bool _isStarred(int num) {
    var file = File("${widget.docsDir}/starred");
    List<int> savedComics = jsonDecode(file.readAsStringSync()).cast<int>();
    if (savedComics.indexOf(num) != -1)
      return true;
    else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      bottomNavigationBar: BottomNavBar(),
      appBar: AppBar(
          backgroundColor: Colors.deepOrange.shade300,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                _addToStarred(widget.comic["num"]);
                setState(() {
                  isStarred = !isStarred;
                });
              },
              icon: isStarred == true
                  ? Icon(Icons.star)
                  : Icon(Icons.star_border),
              tooltip: "star Comic",
            )
          ],
          title: Text("#${widget.comic["num"]}")),
      body: ListView(children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Center(
            child: Text(
              widget.comic["title"],
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
        Container(
          child: InkWell(
            onTap: () {
              _launchComic(widget.comic["num"]);
            },
            splashColor: Colors.blue.withOpacity(0.5),
            highlightColor: Colors.transparent,
            child: Ink.image(
              fit: BoxFit.contain,
              image: FileImage(File(widget.comic['img'])),
              width: 200,
              height: 400,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.deepOrange.shade100),
          child: Text(
            "${widget.comic["alt"]}",
            style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
          ),
        ),
      ]),
    );
  }
}
