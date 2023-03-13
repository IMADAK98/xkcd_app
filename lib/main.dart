import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import 'package:xkcd_app/pages/StarredPage.dart';
import 'package:xkcd_app/pages/selectionPage.dart';
import 'dart:convert';
import 'dart:async';
import 'pages/homeScreen.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<int> getLatestComicNumber() async {
  final dir = await getTemporaryDirectory();
  var file = File('${dir.path}/latestComicNumber.txt');
  int n = 1;
  try {
    n = jsonDecode(
        await http.read(Uri.parse("https://xkcd.com/info.0.json")))["num"];

    file.exists().then((value) {
      if (!value) file.createSync();
      file.writeAsString('$n');
    });
  } catch (e) {
    if (file.existsSync() && file.readAsStringSync() != "")
      n = int.parse(file.readAsStringSync());
  }
  return n;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var latestComicIndex = await getLatestComicNumber();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    color: Colors.red,
    initialRoute: "/",
    routes: {
      "/": (context) =>
          HomeScreen(latestComic: latestComicIndex, mytitle: "XKCD"),
      "/searchPage": (context) => SelectionPage(),
      "/starred": (context) => StarredPage(),
    },
  ));
}
