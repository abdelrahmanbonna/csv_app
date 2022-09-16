import 'dart:io';

import 'package:csv_app/models/item.dart';

/// Main App class..
/// Holds all the main functions of the app
class CSVApp {
  /// Used to store items in CSV file
  final List<Item> listOfItems = [];

  /// Holds the value of the file name to be used in outputs
  String fileName = '';

  /// Gets the data from the file and insert it into the [listOfItems] list
  Future<void> getDataFromCSV(String path) async {
    fileName = path.split('/').last;
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
  Future<void> generateFiles() async {
    await generateFirstOutputFile();
    await generateSecondOutputFile();
  }

  /// Generates first file which contains the name and the avarage
  Future<void> generateFirstOutputFile() async {
    Map sumOfPrd = {};
    Map avarageOfPrd = {};
    File output1 = await File('1_output_$fileName').create(recursive: true);

    // Calculates the sum of all the products
    for (int i = 0; i < listOfItems.length; i++) {
      if (sumOfPrd[listOfItems[i].name] == null) {
        var lastQ = double.parse(sumOfPrd[listOfItems[i].name] ?? '0');
        sumOfPrd[listOfItems[i].name] =
            lastQ + double.parse(listOfItems[i].quantity);
      } else {
        double lastQ = sumOfPrd[listOfItems[i].name] ?? 0;
        sumOfPrd[listOfItems[i].name] =
            lastQ + double.parse(listOfItems[i].quantity);
      }
    }

    // Calculates the avarage for every product
    sumOfPrd.forEach((key, value) {
      avarageOfPrd[key] = value / listOfItems.length;
    });

    //Writes the outputs
    avarageOfPrd.forEach((key, value) async {
      String fileContent = output1.readAsStringSync();
      output1.writeAsStringSync('$fileContent\n$key,$value');
    });
  }

  /// Generates Second file which contains name and most popular brand
  Future<void> generateSecondOutputFile() async {
    Map<String, Map<String, double>> pplrBrand = {};
    File output2 = await File('2_output_$fileName').create(recursive: true);
    for (var element in listOfItems) {
      print('$element\n');
    }

    // Calculating the most popular
    for (int i = 0; i < listOfItems.length; i++) {
      //insert a value for the name if no value found
      //TODO fix Air not showing issue
      if (pplrBrand[listOfItems[i].name] == null) {
        pplrBrand[listOfItems[i].name] = {listOfItems[i].brand: 1};
      } else {
        //insert a value for the brand if no value found and increase it
        if (pplrBrand[listOfItems[i].name]![listOfItems[i].brand] != null) {
          pplrBrand[listOfItems[i].name]![listOfItems[i].brand];
        } else {
          pplrBrand[listOfItems[i].name]![listOfItems[i].brand] = 1;
        }
      }
      print(pplrBrand['shoes']!['Air']);
      print('\n$i:' + pplrBrand.toString());
    }

    //Writes the outputs
    pplrBrand.forEach((name, value) async {
      Map<String, double> mostPop = {
        value.keys.first: value[value.keys.first] ?? 0.0
      };
      value.forEach((brand, value) {
        if (value > (mostPop[mostPop.keys.first] ?? 0.0)) {
          mostPop = {brand: value};
        }
      });
      var fileData = output2.readAsStringSync();
      output2.writeAsStringSync('$fileData\n$name,${mostPop.keys.first}');
    });

    pplrBrand.forEach((key, value) {
      print('$key $value \n');
    });
  }
}



// {
//   "shoes":{
//      "Air":2,
//      "BonPied":1
//   }
//   "forks":{
//      "Pfitzcarft":1
//   }
// }