// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:tldr/tldr.dart';
import 'package:ansicolor/ansicolor.dart';

Future main(List<String> arguments) async {
  if (arguments.length != 1) {
    usage();
    return;
  }
  var command = arguments.single;
  var page = await fetch(command);
  if (page == null) {
    var pen = new AnsiPen()..red();
    print(pen('ERROR:') +
        ' No entry could be found for \'$command\'.');
    exitCode = 1;
    return;
  }
  print(toAnsi(page));
}

usage() {
  print('usage: tldr command-name');
  exitCode = 1;
}
