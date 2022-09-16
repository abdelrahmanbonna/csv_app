import 'package:csv_app/csv_app.dart';
import 'package:test/test.dart';
import 'dart:io';

void main() {
  // Perpare for the test
  String filePath = 'examples/example1.csv';
  CSVApp app = CSVApp();

  //execute
  app.getDataFromCSV(filePath).then((value) {
    app.generateFiles();
  });

  //test
  group('Checking there are outputs', () {
    test('1_output_example1.csv should contain data', () async {
      File output1 = File('1_output_example1.csv');
      assert(await output1.length() > 0);
    });
    test('2_output_example1.csv should contain data', () async {
      File output2 = File('2_output_example1.csv');

      assert(await output2.length() > 0);
    });
  });

  group('Checking the values', () {
    test('1_output_example1.csv should contain name,avarage', () {});

    test('1_output_example1.csv should contain name,brand', () {});
  });
}
