import 'dart:io';

import 'package:brainjuice/brainjuice.dart';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    final s = stdin.readLineSync()!;
    brainjuice(s, {}, 0);
  } else {
    final f = File(arguments.first);
    if (!f.existsSync()) throw "Input file doesn't exist u idiot";
    final code = f.readAsStringSync();
    final memory = <int, int>{};
    brainjuice(code, memory, 0);
  }
}
