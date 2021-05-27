import 'package:mvc_persistence/app/models/device.model.dart';
import 'package:mvc_persistence/app/repositories/device.repository.dart';

class DeviceController {
  List<Device> list = new List<Device>();
  DeviceRepository repository = new DeviceRepository();

  Future<void> getByLogin(int id) async {
    try {
      final allList = await repository.getByLogin(id);
      list.clear();
      list.addAll(allList);
    } catch (e) {
      print("Erro: " + e.toString());
    }
  }

  //Future<void> getByLogin(int id) async {
  //  try {
  //    final listTemp = await repository.getByLogin(id);
  //   list.clear();
  //    list.addAll(listTemp);
  //  } catch (e) {
  //    throw new Exception("Erro ao fazer login");
  //  }
  //}

  Future<void> create(Device device) async {
    try {
      list.add(device);
      await repository.create(device);
    } catch (e) {
      print("Erro: " + e.toString());
    }
  }

  //Future<void> delete(int id) async {
  //  try {
  //    list.removeAt(id);
  //    await repository.delete(id);
  //  } catch (e) {
  //    print("Erro: " + e.toString());
  //  }
  //}

  //Future<void> update(Device device) async {
  //  await repository.update(device);
  //  await getAll();
  //}
}
