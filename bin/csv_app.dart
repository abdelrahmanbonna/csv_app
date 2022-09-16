import 'dart:io';

import 'package:csv_app/csv_app.dart';

void main(List<String> arguments) async {
  CSVApp app = CSVApp(); //Main App class

  print("Welcome to the CSV Exercise");
  print("Enter the path of the file:");
  var path = stdin.readLineSync(); //Takes the examples/example1.csv

  await app.getDataFromCSV(path.toString()); //Generates the items in the [listOfItems]

  await app.generateFiles(); //Generates the files
}
