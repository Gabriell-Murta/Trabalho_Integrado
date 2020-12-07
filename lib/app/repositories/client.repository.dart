import 'dart:convert';

import 'package:mvc_persistence/app/models/client.model.dart';
import 'package:mvc_persistence/app/settings.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/client.model.dart';

class ClientRepository {
  Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) {
        return db.execute(CREATE_LISTS_TABLE_SCRIPT);
      },
      version: 1,
    );
  }

   Future<List<Client>> getAll() async {
    try {
      var response =
      await http.get(Uri.encodeFull("https://tapegandofogobicho.azurewebsites.net/api/v1/Client/"));
      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List)
            .map((x) => Client.fromJson(x))
            .toList();
      }

      throw new Exception();
    } catch (e) {
      print("FUDEU CLIENT REPOSITORIO GETALL");

      return new List<Client>();
    }
  }
  Future<bool> Create(Client client) async {
    try {
      var response =
      await http.put(Uri.encodeFull("https://tapegandofogobicho.azurewebsites.net/api/v1/Client/"), body:jsonEncode(client.toJson()), headers:{"Content-Type":"application/json"});
      print("status code:${response.statusCode}");
      if (response.statusCode == 201) {
        return true;
      }

      throw new Exception();
    } catch (e) {
      print("FUDEU CLIENT REPOSITORIO CREATE: ${e.toString()}");

      return false;
    }
  }

  Future<Client> read(int id) async {
    try {
      final Database db = await _getDB();
      final List<Map<String, dynamic>> maps = await db.query(
        TABLE_NAME,
        where: "IdClient = ?",
        whereArgs: [id],
      );

      return Client(
        Nome : maps[0]['Nome'],
        IdClient: maps[0]['IdClient'],
        Email: maps[0]['Email'],
        Logradouro: maps[0]['Logradouro'],
        Bairro: maps[0]['Bairro'],
        Numero: maps[0]['Numero'],
        Cidade: maps[0]['Cidade'],
        Estado: maps[0]['Estado'],
        Telefone: maps[0]['Telefone'],
        CpfCnpj: maps[0]['CpfCnpj'],
        Senha: maps[0]['Senha'],
      );
    } catch (ex) {
      print(ex);
      return new Client();
    }
  }

  Future update(Client item) async {
    try {
      final Database db = await _getDB();
      await db.update(
        TABLE_NAME,
        item.toMap(),
        where: "IdClient = ?",
        whereArgs: [item.IdClient],
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
        where: "IdClient = ?",
        whereArgs: [id],
      );
    } catch (e) {
      print(e);
      return;
    }
  }
}
