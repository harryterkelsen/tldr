library tldr.src.fetch_page;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import 'page.dart';
import 'parse.dart';

final String baseUrl =
    'https://raw.githubusercontent.com/tldr-pages/tldr/master/pages/';

Iterable<String> get prefixes {
  var folders = ['common'];
  if (Platform.isLinux) {
    folders.add('linux');
  }
  if (Platform.isMacOS) {
    folders.add('osx');
  }
  return folders.map((folder) => path.join(baseUrl, folder));
}

Future<Page> fetch(String command) async {
  for (var prefix in prefixes) {
    var rawPage = await http.get(path.join(prefix, command + '.md'));
    if (rawPage.statusCode == 200) {
      var page = parseLines(LineSplitter.split(rawPage.body));
      if (page != null) return page;
    }
  }
  return null;
}
