import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class isDownload {
  Future<Map<String, dynamic>> downloadComic(
      String comicNumber, File directory) async {
    // create a new file
    directory.createSync();
    // we read the JSON object and store the contents inside the comic variable
    final comic = json.decode(await http
        .read(Uri.parse("https://xkcd.com/$comicNumber/info.0.json")));
    // Here we get the comic img url content and read it as bytes to store it in the bytes variable
    final bytes = await http.readBytes(Uri.parse(comic["img"]));
    // here we write to the file the bytes content (which is the image we downloaded)
    File('${directory}/$comicNumber.png').writeAsBytesSync(bytes);
    // we set the comic[img] content to the path of
    comic["img"] = "${directory}/$comicNumber.png";
    directory.writeAsString(json.encode(comic));
    return comic;
  }
}
