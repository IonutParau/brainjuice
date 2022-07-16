import 'dart:io';
import 'dart:math';

void brainjuice(String code, Map<int, int> memory, int pointer) {
  final chars = code.split('');
  var i = 0;
  var blocked = <String>{};

  while (true) {
    if (i >= chars.length) break;
    final c = chars[i];
    if (blocked.contains(c)) {
      i++;
      continue;
    }
    switch (c) {
      case '>':
        pointer++;
        if (memory[pointer] == null) memory[pointer] = 0;
        break;
      case '<':
        pointer--;
        if (memory[pointer] == null) memory[pointer] = 0;
        break;
      case '+':
        memory[pointer] = ((memory[pointer] ?? 0) + 1);
        break;
      case '-':
        memory[pointer] = ((memory[pointer] ?? 0) - 1);
        break;
      case '.':
        stdout.write(String.fromCharCode((memory[pointer] ?? 0)));
        break;
      case ',':
        final l = stdin.readLineSync();
        if (l == null) {
          memory[pointer] = 0;
        } else if (l.isEmpty) {
          memory[pointer] = 0;
        } else {
          memory[pointer] = l.codeUnits.first;
        }
        break;
      case '[':
        if ((memory[pointer] ?? 0) == 0) {
          int depth = 1;
          while (depth > 0) {
            i++;
            if (chars[i] == '[') depth++;
            if (chars[i] == ']') depth--;
          }
        }
        break;
      case ']':
        if ((memory[pointer] ?? 0) != 0) {
          int depth = 1;
          while (depth > 0) {
            i--;
            if (chars[i] == ']') depth++;
            if (chars[i] == '[') depth--;
          }
        }
        break;
      case '0':
        memory[pointer] = 0;
        break;
      case ';':
        i++;
        memory[pointer] = chars[i].codeUnits.first;
        break;
      case '*':
        memory[pointer] = (memory[pointer] ?? 0) * (memory[pointer + 1] ?? 0);
        break;
      case '/':
        memory[pointer] = (memory[pointer] ?? 0) ~/ (memory[pointer + 1] ?? 0);
        break;
      case '^':
        memory[pointer] = pow((memory[pointer] ?? 0), (memory[pointer + 1] ?? 0)).toInt();
        break;
      case '%':
        memory[pointer] = (memory[pointer] ?? 0) % (memory[pointer + 1] ?? 0);
        break;
      case '~':
        memory[pointer] = log((memory[pointer] ?? 0)).toInt();
        break;
      case '\$':
        pointer = 0;
        break;
      case '@':
        pointer = memory[pointer] ?? 0;
        break;
      case ':':
        var n = "";

        i++;
        while (chars[i] != ':') {
          n += chars[i];
          i++;
        }

        memory[pointer] = int.parse(n);
        break;
      case '(':
        if ((memory[pointer] ?? 0) == 0) {
          int depth = 1;
          while (depth > 0) {
            i++;
            if (chars[i] == '(') depth++;
            if (chars[i] == ')') depth--;
          }
        }
        break;
      case '&':
        memory[pointer] = pointer;
        break;
      case '{':
        var tmp = memory[pointer] ?? 0;
        memory[pointer] = memory[pointer - 1] ?? 0;
        memory[pointer - 1] = tmp;
        break;
      case '}':
        var tmp = memory[pointer] ?? 0;
        memory[pointer] = memory[pointer + 1] ?? 0;
        memory[pointer + 1] = tmp;
        break;
      case '#':
        brainjuice(String.fromCharCode(memory[pointer] ?? 0), memory, 0);
        break;
      case "`":
        var bc = String.fromCharCode(memory[pointer] ?? 0);
        if (blocked.contains(bc)) {
          blocked.remove(bc);
        } else {
          blocked.add(bc);
        }
        break;
      case '"':
        i++;
        while (chars[i] != "\"") {
          stdout.write(chars[i]);
          i++;
        }
        break;
      case "_":
        memory[pointer] = memory[memory[pointer] ?? 0] ?? 0;
        break;
      case "|":
        memory[pointer] = memory[memory[memory[pointer] ?? 0] ?? 0] ?? 0;
        break;
      case "\\":
        var txt = "";
        var m = pointer + 1;
        while ((memory[m] ?? 0) > 0) {
          txt += String.fromCharCode(memory[m] ?? 0);
          m++;
        }
        brainjuice(txt, memory, 0);
        break;
    }
    i++;
  }
}
