import 'dart:convert';
import 'package:mvc_persistence/app/models/client.model.dart';
import 'package:http/http.dart' as http;

class ClientRepository {
   Future<Client> getByLogin(String cpf, String senha) async {
    try {
      var response =
      await http.get(Uri.parse("https://fechadura.azurewebsites.net/api/v1/Client/$cpf/$senha"));
      
      if (response.statusCode == 200) {
        return (Client.fromJson(jsonDecode(response.body)));
      }

      throw new Exception(jsonDecode(response.body));
    } catch (e) {
      return new Client();
    }
  }
  Future<bool> create(Client client) async {
    try {
      var response = await http.post(Uri.parse("https://fechadura.azurewebsites.net/api/v1/Client/"),
        body: jsonEncode(client.toJson()),
        headers: {"Content-Type":"application/json"});
      
      if (response.statusCode == 201) {
        return true;
      }

      throw new Exception(jsonDecode(response.body));
    } catch (e) {
      return false;
    }
  }
}
