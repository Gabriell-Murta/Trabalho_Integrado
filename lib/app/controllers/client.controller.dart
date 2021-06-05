import 'package:mvc_persistence/app/models/client.model.dart';
import 'package:mvc_persistence/app/repositories/client.repository.dart';

class ClientController {
  Client cliente = Client();
  ClientRepository repository = new ClientRepository();

  Future<void> getByLogin(String cpf, String senha) async {
    try {
      cliente = await repository.getByLogin(cpf,senha);
    } catch (e) {
      print("Erro: " + e.toString());
    }
  }

  Future<void> create(Client client) async {
    try {
      cliente = client;
      await repository.create(client);
    } catch (e) {
      print("Erro: " + e.toString());
    }
  }
}