import 'dart:convert';

import 'package:mvc_persistence/app/models/device.model.dart';
import 'package:mvc_persistence/app/settings.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../models/ibge.model.dart';

class IbgeRepository {
  Future<List<Estado>> getEstados() async {
    try {
      var response = await http.get(Uri.encodeFull(
          "https://servicodados.ibge.gov.br/api/v1/localidades/estados?orderBy=nome"));
      // print(response.body);
      return (jsonDecode(response.body) as List)
          .map((x) => Estado.fromJson(x))
          .toList();
    } catch (e) {
      print("FUDEU ${e.toString()}");

      return new List<Estado>();
    }
  }
}
