import 'dart:convert';
import 'dart:io';

import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xkcd_app/Utilit/fetchComic.dart';
import 'package:xkcd_app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xkcd_app/pages/comicPage.dart';
import 'package:xkcd_app/pages/errorPage.dart';
import '../Utilit/bottomNavBar.dart';
import "selectionPage.dart";

import '../Utilit/comicTile.dart';

class HomeScreen extends StatelessWidget {
  final int latestComic;
  final String mytitle;
  HomeScreen({
    super.key,
    required this.latestComic,
    required this.mytitle,
  });
// Function to get the data from the JSON url and return a Future map object with String keys and dynamic values
//  the function takes an int n as argument
  Future<Map<String, dynamic>> _fetchComic(int n) async {
    FetchComic fetch = FetchComic();
    return fetch.fetchHomeScreenComic(latestComic, n);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavBar(),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/searchPage");
              },
              icon: Icon(Icons.search),
              tooltip: "Search for comic ",
            ),
            IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/starred");
              },
              icon: Icon(Icons.star),
              tooltip: "browse Starred Comics",
            )
          ],
          title: Text(mytitle),
          centerTitle: true,
        ),
        body: ListView.separated(
          itemCount: latestComic,
          itemBuilder: (context, index) => FutureBuilder(
            future: _fetchComic(index),
            builder: (context, comicResult) {
              return comicResult.hasData
                  ? ComicTile(comic: comicResult.data!)
                  : Container(
                      child: Center(child: CircularProgressIndicator()),
                    );
            },
          ),
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              thickness: 2,
              color: Colors.black45,
            );
          },
        ));
  }
}
