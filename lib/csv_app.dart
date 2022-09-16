import 'dart:io';

import 'package:csv_app/models/item.dart';
/// Main App class 
/// Holds all the main functions of the app
class CSVApp {
  /// Used to store items in CSV file
  final List<Item> listOfItems = [];

  /// Gets the data from the file and insert it into the [listOfItems] list
  Future<void> getDataFromCSV(String path) async {
    File file = File(path);
    String data = await file.readAsString();

    data.split('\n').forEach((element) {
      Item item = Item.empty();
      var row = element.split(',');
      for (int i = 0; i < row.length; i++) {
        if (i == 0) {
          item.id = row[i];
        } else if (i == 1) {
          item.area = row[i];
        } else if (i == 2) {
          item.name = row[i];
        } else if (i == 3) {
          item.quantity = row[i];
        } else if (i == 4) {
          item.brand = row[i];
        }
      }
      listOfItems.add(item);
    });
  }

  /// Generates the 2 output files from the [listOfItems] list
  Future<void> generateFiles() async {}
}
