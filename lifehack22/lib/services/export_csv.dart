
import 'dart:html';

import 'package:csv/csv.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:ext_storage/ext_storage.dart';
import 'dart:io';

/*
class ExportCsv {
  final List data;
  ExportCsv({required this.data});

  List<List<dynamic>> rows = [];

  downloadData() {
    for (int i = 0; i < data.length; i++) {
      List<dynamic> row = [];
      row.add(data[i]["name"]);
      row.add(data[i]["phone"]);
      row.add(data[i]["email"]);
      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);
    AnchorElement(href: "data:text/plain;charset=utf-8,$csv")
      ..setAttribute("download", "data.csv")
      ..click();
  }
}
*/