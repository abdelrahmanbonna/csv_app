import 'dart:io';

import 'package:csv_app/csv_app.dart';

void main(List<String> arguments) {
  CSVApp app = CSVApp();

  print("Welcome to the CSV Exercise");
  print("Enter the path of the file:");
  var path = stdin.readLineSync();

  app.getDataFromCSV(path.toString());
}
