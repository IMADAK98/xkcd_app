import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:xkcd_app/pages/comicPage.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        title: Text('Error page'),
        backgroundColor: Colors.deepOrange.shade300,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Icon(
            Icons.not_interested,
            size: 50,
          ),
        ),
        Text('The comics you are looking for does not exist' +
            " or is not avaliable")
      ]),
    );
  }
}
