/// Parse a raw tldr page into a [Page].
library tldr.src.parse;

import 'page.dart';

Page parseLines(Iterable<String> lines) {
  var name;
  var description = <String>[];
  var exampleDescription;
  var examples = <Example>[];
  var expecting = '#';
  for (var line in lines) {
    line = line.trim();
    if (line.isEmpty) continue;

    if (expecting == '#') {
      if (!line.startsWith('#')) return null;
      name = line.substring(1).trim();
      expecting = '>';
      continue;
    }

    if (expecting == '>' && line.startsWith('-')) {
      expecting = '-';
    } else if (expecting == '>') {
      if (!line.startsWith('>')) return null;
      description.add(line.substring(1).trim());
      continue;
    }

    if (expecting == '-') {
      if (!line.startsWith('-')) return null;
      exampleDescription = line.substring(1).trim();
      expecting = '`';
      continue;
    }

    if (expecting == '`') {
      if (!line.startsWith('`')) return null;
      if (!line.endsWith('`')) return null;
      examples.add(new Example(exampleDescription,
          line.substring(1, line.length - 1).trim()));
      exampleDescription = null;
      expecting = '-';
      continue;
    }
  }

  if (name == null ||
      description.isEmpty ||
      examples.isEmpty ||
      exampleDescription != null) {
    return null;
  }

  return new Page(name, description, examples);
}
