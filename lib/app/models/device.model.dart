import 'package:mvc_persistence/app/models/medicao.model.dart';

class Device {
  int IdDevice;
  String Nome;
  DateTime Criado_em;
  DateTime Desativado_em;
  

  Device(
      {this.IdDevice,
      this.Nome,
      this.Criado_em,
      this.Desativado_em,
      });

  Map<String, dynamic> toMap() {
    return {
      'id': IdDevice,
      'mick': Nome,
      'createdIn': Criado_em,
      'disabledIn': Desativado_em
    };
  }

  Device.fromJson(Map<String, dynamic> json) {
    //print(json['measurements']);
    IdDevice = json['id'];
    Nome = json['nick'];
    Criado_em =  DateTime.parse(json['createdIn']);
    Desativado_em = DateTime.parse(json['disabledIn']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nick'] = this.Nome;
    data['id'] = this.IdDevice;
    data['createdIn'] = this.Criado_em;
    data['disabledIn'] = this.Desativado_em;
    return data;
  }
}
