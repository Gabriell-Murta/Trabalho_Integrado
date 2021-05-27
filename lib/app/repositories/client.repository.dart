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

   Future<Client> getByLogin(String cpf, String senha) async {
    try {
      var response =
      await http.get(Uri.encodeFull("https://fechadura.azurewebsites.net/api/v1/Client/$cpf/$senha"));
      if (response.statusCode == 200) {
        print(response.body);
        return (Client.fromJson(jsonDecode(response.body)));
      }

      throw new Exception();
    } catch (e) {
      print("FUDEU CLIENT REPOSITORIO GETALL");

      return new Client();
    }
  }
  Future<bool> create(Client client) async {
    try {
      var response =
      await http.post(Uri.encodeFull("https://fechadura.azurewebsites.net/api/v1/Client/"), body:jsonEncode(client.toJson()), headers:{"Content-Type":"application/json"});
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
        where: "clientId = ?",
        whereArgs: [id],
      );

      return Client(
        Nome : maps[0]['name'],
        IdClient: maps[0]['clientId'],
        Email: maps[0]['email'],
        Logradouro: maps[0]['address'],
        Bairro: maps[0]['district'],
        Numero: maps[0]['number'],
        Cidade: maps[0]['city'],
        Estado: maps[0]['uf'],
        Cep: maps[0]['postalCode'],
        CpfCnpj: maps[0]['cpf'],
        Senha: maps[0]['password'],
        Criado_em: maps[0]['createdIn'],
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
        where: "clientId = ?",
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
        where: "clientId = ?",
        whereArgs: [id],
      );
    } catch (e) {
      print(e);
      return;
    }
  }
}
