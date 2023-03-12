import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FetchComic {
  Future<Map<String, dynamic>> fetchComic(String n) async {
    final dir = await getTemporaryDirectory();
    var comicFile = File("${dir.path}/$n.json");

    if (await comicFile.exists() && comicFile.readAsStringSync().isNotEmpty) {
      return jsonDecode(comicFile.readAsStringSync());
    } else {
      comicFile.createSync();
      final comic = jsonDecode(
          await http.read(Uri.parse("https://xkcd.com/$n/info.0.json")));
      File('${dir.path}/$n.png')
          .writeAsBytesSync(await http.readBytes(comic["img"]));
      comic["img"] = "${dir.path}/$n.png";
      comicFile.writeAsString(json.encode(comic));
      return comic;
    }
  }

  Future<Map<String, dynamic>> fetchHomeScreenComic(
      int latestcomicInd, int n) async {
    // try block
    try {
      // Creating a directory
      final dir = await getTemporaryDirectory();
      // storing the Comic number which we get from main function
      int comicNumber = latestcomicInd - n;
      // creating a new file where we store the latest JSON url
      var comicFile = File("${dir.path}/$comicNumber.json");
      // checks if the comic file exists and is not empty then returns the stored JSON object in the Comicfile.
      if (await comicFile.exists() && comicFile.readAsStringSync() != "") {
        return json.decode(comicFile.readAsStringSync());
      }
      // if the file is not created or its not empty then we perform several operations
      else {
        // create a new file
        comicFile.createSync();
        // we read the JSON object and store the contents inside the comic variable
        final comic = json.decode(await http
            .read(Uri.parse("https://xkcd.com/$comicNumber/info.0.json")));
        // Here we get the comic img url content and read it as bytes to store it in the bytes variable
        final bytes = await http.readBytes(Uri.parse(comic["img"]));
        // here we write to the file the bytes content (which is the image we downloaded)
        File('${dir.path}/$comicNumber.png').writeAsBytesSync(bytes);
        // we set the comic[img] content to the path of the downloaded image
        comic["img"] = '${dir.path}/$comicNumber.png';
        // Lastly we convert the url String (comic) into a JSON object and we save it in the comic file
        comicFile.writeAsString(json.encode(comic));
        // finally we return the comic JSON object
        return comic;
      }
      // catch the error and print it
    } catch (e) {
      print("Error fetching comic 1: $e");
      return Future.error(e);
    }
  }

  Future<Map<String, dynamic>?> fetchSelection(String n) async {
    // try block
    try {
      // Creating a directory
      final dir = await getTemporaryDirectory();
      // creating a new file where we store the latest JSON url
      var comicFile = File('${dir.path}/$n.json');
      // check that the file exists and contents are not empty
      if (await comicFile.exists() && comicFile.readAsStringSync().isNotEmpty) {
        var jsonObject = await jsonDecode(comicFile.readAsStringSync());
        // check that the path of the image matches the one in the cache and return it if true
        if (jsonObject["img"] == "${dir.path}/$n.png") {
          return jsonObject;
        }
        // if the path does not match download the image and return the json object "comic"
        else if (jsonObject["img"] != "${dir.path}/$n.png") {
          final comic = jsonDecode(
              await http.read(Uri.parse("https://xkcd.com/$n/info.0.json")));
          File("${dir.path}/$n.png")
              .writeAsBytesSync(await http.readBytes(Uri.parse(comic["img"])));
          comic["img"] = "${dir.path}/$n.png";
          comicFile.writeAsStringSync(jsonEncode(comic));
          return comic;
        }
      }

      // download the image if another unexpected problem occur anyway.
      else {
        comicFile.createSync;
        print('what the fuuuuk');
        final comic = jsonDecode(
            await http.read(Uri.parse("https://xkcd.com/$n/info.0.json")));
        File("${dir.path}/$n.png")
            .writeAsBytesSync(await http.readBytes(Uri.parse(comic["img"])));
        comic["img"] = "${dir.path}/$n.png";
        comicFile.writeAsStringSync(jsonEncode(comic));
        return comic;
      }
    }

    // catch the error and print it
    catch (e) {
      print("Error fetching comic 2: $e");
      return Future.error(e);
    }
  }
}
