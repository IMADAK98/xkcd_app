import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:xkcd_app/Utilit/bottomNavBar.dart';
import 'package:xkcd_app/Utilit/comicTile.dart';
import 'package:xkcd_app/Utilit/fetchComic.dart';

class StarredPage extends StatelessWidget {
  const StarredPage({super.key});

  Future<Map<String, dynamic>> _fetchComic(String n) async {
    FetchComic fetch = FetchComic();
    return fetch.fetchComic(n);
  }

  Future<List<Map<String, dynamic>>> _retrieveSavedComics() async {
    Directory docsDir = await getApplicationDocumentsDirectory();
    File file = File('${docsDir.path}/starred');
    List<Map<String, dynamic>> comics = [];

    if (!file.existsSync()) {
      file.createSync();
      file.writeAsStringSync("[]");
    } else {
      json
          .decode(file.readAsStringSync())
          .forEach((n) async => comics.add(await _fetchComic(n.toString())));
    }
    return comics;
  }

  @override
  Widget build(BuildContext context) {
    var comics = _retrieveSavedComics();
    return Scaffold(
        bottomNavigationBar: BottomNavBar(),
        appBar: AppBar(
          title: Text("Browse your Favorite Comics"),
        ),
        body: FutureBuilder(
            future: comics,
            builder: (context, snapshot) =>
                snapshot.hasData && snapshot.data!.isNotEmpty
                    ? ListView.separated(
                        itemBuilder: (context, index) => ComicTile(
                          comic: snapshot.data![index],
                        ),
                        itemCount: snapshot.data!.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            thickness: 2,
                            color: Colors.black45,
                          );
                        },
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.not_interested),
                          Text(''' You haven't starred any comics yet.
          check back after you have found something worthy of being here''')
                        ],
                      )));
  }
}
