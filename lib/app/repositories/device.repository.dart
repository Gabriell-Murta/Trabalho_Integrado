import 'dart:convert';

import 'package:mvc_persistence/app/models/device.model.dart';
import 'package:mvc_persistence/app/settings.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/device.model.dart';

class DeviceRepository {
  Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) {
        return db.execute(CREATE_LISTS_TABLE_SCRIPT);
      },
      version: 1,
    );
  }

  Future create(Device item) async {
    try {
      var device = item.toMap();
      device.remove("id");
      final Database db = await _getDB();
      await db.insert(
        TABLE_NAME,
        device,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<List<Device>> getByLogin(int login) async {
    try {
      var response = await http.get(Uri.encodeFull(
          "https://fechadura.azurewebsites.net/api/v1/Devices?clientId=$login"));
      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List)
            .map((x) => Device.fromJson(x))
            .toList();
      }

      throw new Exception();
    } catch (e) {
      print("FUDEU");

      return new List<Device>();
    }
  }

  //Future<List<Device>> getByLogin(String login, String senha) async {
    //try {
      //var url =
        //  "https://tapegandofogobicho.azurewebsites.net/api/v1/Devices?cpf=$login&senha=$senha";
      //var response = await http.get(Uri.encodeFull(url));
      //if (response.statusCode == 200) {
        //var temp = (jsonDecode(response.body) as List)
            //.map((x) => Device.fromJson(x))
          //  .toList();
        //return temp;
      //}
      //print(response.statusCode);

    //  throw new Exception("Erro ao fazer login");
  //  } catch (e) {
//      print("FUDEU Login" + e);

    //  return new List<Device>();
   // }
 // }

  Future<Device> read(int id) async {
    try {
      final Database db = await _getDB();
      final List<Map<String, dynamic>> maps = await db.query(
        TABLE_NAME,
        where: "id = ?",
        whereArgs: [id],
      );

      return Device(
        IdDevice : maps[0]['id'],
        Nome : maps[0]['nick'],
        Criado_em : maps[0]['createdIn'],
        Desativado_em : maps[0]['disabledIn']
      );
    } catch (ex) {
      print(ex);
      return new Device();
    }
  }

  Future update(Device item) async {
    try {
      final Database db = await _getDB();
      await db.update(
        TABLE_NAME,
        item.toMap(),
        where: "id = ?",
        whereArgs: [item.IdDevice],
      );
    } catch (e) {
      print(e);
      return;
    }
  }

  Future delete(int id) async {
    try {
      final Database db = await _getDB();
      await db.delete(
        TABLE_NAME,
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (e) {
      print(e);
      return;
    }
  }
}
