import 'package:mvc_persistence/app/models/ibge.model.dart';
import 'package:mvc_persistence/app/repositories/ibge.repository.dart';

class EstadoController {
  List<Estado> list = new List<Estado>();
  IbgeRepository repository = new IbgeRepository();

  Future<void> getEstados() async {
    try {
      final listTemp = await repository.getEstados();
      list.clear();
      list.addAll(listTemp);
    } catch (e) {
      throw new Exception("Erro ao carregar estados");
    }
  }
}
