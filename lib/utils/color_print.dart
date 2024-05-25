import 'package:ansicolor/ansicolor.dart';

class Print {
  Print(String content) {
    print(pen(content));
  }
  Print.error(String content) {
    print(errorPen(content));
  }
  Print.success(String content) {
    print(successPen(content));
  }
  Print.warn(String content) {
    print(warningPen(content));
  }

  AnsiPen successPen = AnsiPen()..green(bold: true);
  AnsiPen errorPen = AnsiPen()..red(bold: true);
  AnsiPen warningPen = AnsiPen()..yellow(bold: true);
  AnsiPen pen = AnsiPen()..white(bold: true);
}
