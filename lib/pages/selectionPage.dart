import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:xkcd_app/Utilit/bottomNavBar.dart';
import 'package:xkcd_app/Utilit/fetchComic.dart';
import 'package:xkcd_app/Utilit/isDownload.dart';

import 'package:xkcd_app/pages/comicPage.dart';

import 'errorPage.dart';

TextEditingController _controller = new TextEditingController();

class SelectionPage extends StatelessWidget {
  Future<Map<String, dynamic>?> _fetchComic(String n) async {
    FetchComic fetchComic = FetchComic();
    return fetchComic.fetchSelection(n);
  }

  SelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavBar(),
        appBar: AppBar(
          title: Text('Comic selection'),
          centerTitle: true,
        ),
        body: Center(
          child: TextField(
            controller: _controller,
            autofocus: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: 'Enter Comic #',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
            onSubmitted: (String a) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FutureBuilder(
                    future: _fetchComic(a),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return ErrorPage();
                      }
                      if (snapshot.hasData) {
                        return ComicPage(comic: snapshot.data!);
                      }
                      return Center(
                          child: CircularProgressIndicator(
                        backgroundColor: Colors.amberAccent,
                      ));
                    },
                  ),
                ),
              );

              _controller.clear(); // clears the text field after submission
            },
          ),
        ));
  }
}
