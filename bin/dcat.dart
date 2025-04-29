import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';

const lineNumber = 'line-number';
const writeFlag = 'write';

void main(List<String> arguments) {
  exitCode = 0;

  final parser =
      ArgParser()
        ..addFlag(lineNumber, negatable: false, abbr: 'n')
        ..addOption(writeFlag, abbr: 'w', help: 'Write content to a file');

  final argResults = parser.parse(arguments);

  if (argResults.wasParsed(writeFlag)) {
    final contentToWrite = argResults[writeFlag] as String;
    WriteFile(contentToWrite);
  } else {
    final paths = argResults.rest;
    dcat(paths, showLineNumbers: argResults[lineNumber] as bool);
  }
}

Future<void> dcat(List<String> paths, {bool showLineNumbers = false}) async {
  if (paths.isEmpty) {
    await stdin.pipe(stdout);
  } else {
    for (final path in paths) {
      var lineNumber = 1;
      final lines = utf8.decoder
          .bind(File(path).openRead())
          .transform(const LineSplitter());
      try {
        await for (final line in lines) {
          if (showLineNumbers) {
            stdout.write('${lineNumber++} ');
          }
          stdout.writeln(line);
        }
      } catch (_) {
        await _handleError(path);
      }
    }
  }
}

Future<void> WriteFile(String content) async {
  final file = File('output.txt');
  try {
    await file.writeAsString(content, mode: FileMode.append);
    stdout.writeln('Content written to output.txt');
  } catch (e) {
    stderr.writeln('Failed to write to file: $e');
    exitCode = 1;
  }
}

Future<void> _handleError(String path) async {
  if (await FileSystemEntity.isDirectory(path)) {
    stderr.writeln('error: $path is a directory');
  } else {
    exitCode = 2;
  }
}
