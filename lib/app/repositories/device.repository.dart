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
      device.remove("IdDevice");
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

  Future<List<Device>> getAll() async {
    try {
      var response = await http.get(Uri.encodeFull(
          "https://tapegandofogobicho.azurewebsites.net/api/v1/Devices/4"));
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

  Future<List<Device>> getByLogin(String senha, String login) async {
    try {
      var response = await http.get(Uri.encodeFull(
          "https://tapegandofogobicho.azurewebsites.net/api/v1/Devices?cpf=$login&senha$senha"));
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

  Future<Device> read(int id) async {
    try {
      final Database db = await _getDB();
      final List<Map<String, dynamic>> maps = await db.query(
        TABLE_NAME,
        where: "IdDevice = ?",
        whereArgs: [id],
      );

      return Device(
        IdDevice: maps[0]['IdDevice'],
        IdClient: maps[0]['IdClient'],
        Nick: maps[0]['Nick'],
        Latitude: maps[0]['Latitude'],
        Longitude: maps[0]['Longitude'],
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
        where: "IdDevice = ?",
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
        where: "IdDevice = ?",
        whereArgs: [id],
      );
    } catch (e) {
      print(e);
      return;
    }
  }
}
