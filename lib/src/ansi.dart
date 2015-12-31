import 'package:ansicolor/ansicolor.dart';

import 'page.dart';

AnsiPen _green = new AnsiPen()..green();
AnsiPen _redOnBlack = new AnsiPen()
  ..red()
  ..black(bg: true);
AnsiPen _white = new AnsiPen()..white();

String toAnsi(Page page) {
  var buffer = new StringBuffer();
  buffer.writeln();
  for (var description in page.description) {
    buffer.writeln(description);
  }
  for (var example in page.examples) {
    buffer.writeln();
    buffer.write(_green('- '));
    buffer.writeln(_green(example.description));
    buffer.writeln();
    buffer.write('  ');
    buffer.writeln(_colorizeCommand(example.command));
  }
  return buffer.toString();
}

String _colorizeCommand(String command) {
  var base = _redOnBlack.down;
  base += command.replaceAllMapped(new RegExp(r'{{([^}]*)}}'),
      (match) {
    return _white(match.group(1)) + _redOnBlack.down;
  });
  base += _redOnBlack.up;
  return base;
}
