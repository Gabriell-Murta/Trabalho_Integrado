import 'package:mvc_persistence/app/models/device.model.dart';
import 'package:mvc_persistence/app/repositories/device.repository.dart';

class DeviceController {
  List<Device> list = List<Device>.empty(growable: true);
  DeviceRepository repository = DeviceRepository();

  Future<void> getByLogin(int? id) async {
    try {
      final allList = await repository.getByLogin(id);
      
      list = allList;
    } catch (e) {
      print("Erro: " + e.toString());
    }
  }

  Future<void> create(String nick, int? clientId) async {
    try {
      final deviceId = await repository.createDevice(clientId,nick);
      
      Device device = Device(idDevice: deviceId, nome: nick, criadoEm: DateTime.now());
      
      list.add(device);
    } catch (e) {
      print("Erro: " + e.toString());
    }
  }
}
