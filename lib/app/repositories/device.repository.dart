import 'package:mvc_persistence/app/models/device.model.dart';
import 'package:mvc_persistence/app/settings.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
      final Database db = await _getDB();
      await db.insert(
        TABLE_NAME,
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<List<Device>> getAll() async {
    try {
      final Database db = await _getDB();
      final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);

      return List.generate(
        maps.length,
        (index) => Device(
          IdDevice: maps[index]['IdDevice'],
          IdClient: maps[index]['IdClient'],
          Nick: maps[index]['Nick'],
          Location: maps[index]['Location'],
        ),
      );
    } catch (e) {
      print(e);
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
        Location: maps[0]['Location'],
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
