import 'package:mvc_persistence/app/models/client.model.dart';
import 'package:mvc_persistence/app/repositories/client.repository.dart';

class ClientController {
  List<Client> list = new List<Client>();
  ClientRepository repository = new ClientRepository();

  Future<void> getAll() async {
    try {
      final allList = await repository.getAll();
      list.clear();
      list.addAll(allList);
    } catch (e) {
      print("Erro: " + e.toString());
    }
  }

  Future<void> Create(Client client) async {
    try {
      list.add(client);
      await repository.Create(client);
    } catch (e) {
      print("Erro: " + e.toString());
    }
  }

  Future<void> delete(int id) async {
    try {
      list.removeAt(id);
      await repository.delete(id);
    } catch (e) {
      print("Erro: " + e.toString());
    }
  }

  Future<void> update(Client client) async {
    await repository.update(client);
    await getAll();
  }
}