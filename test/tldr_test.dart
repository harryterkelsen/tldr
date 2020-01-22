// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library tldr.test;

import 'package:test/test.dart';
import 'package:tldr/src/parse.dart';

void main() {
  test('parse simple tldr', () {
    var tar = r'''
# tar

> Archiving utility
> Optional compression with gzip / bzip

- create an archive from files

`tar cf {{target.tar}} {{file1 file2 file3}}`

- create a gzipped archive

`tar czf {{target.tar.gz}} {{file1 file2 file3}}`

- extract an archive in a target folder

`tar xf {{source.tar}} -C {{folder}}`
    ''';
    var page = parseLines(tar.split('\n'));
    expect(page, isNotNull);
    expect(page.name, 'tar');
    expect(page.description,
        ['Archiving utility', 'Optional compression with gzip / bzip']);
    expect(page.examples.length, 3);
    expect(page.examples.first.description, 'create an archive from files');
    expect(page.examples.first.command,
        'tar cf {{target.tar}} {{file1 file2 file3}}');
  });
}
