import 'dart:ffi';

class Medicao {
  int IdMedicao;
  int IdDevice;
  double Temperature;
  double Smoke;
  double Gas;
  double AirHumidity;
  DateTime UpdateDate;
  double Danger;

  Medicao.fromJson(Map<String, dynamic> json) {
    try {
      IdMedicao = json['idMedicao'];
      IdDevice = json['idDevice'];
      Temperature = json['temp'];
      Smoke = json['cmonoxide'];
      Gas = json['gas'];
      AirHumidity = json['humidity'];
      UpdateDate = DateTime.parse(json['updateDate']);
      Danger = json['danger'];
    } catch (e) {
      print("AAAA ${e.toString()}");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idMedicao'] = this.IdMedicao;
    data['idDevice'] = this.IdDevice;
    data['temp'] = this.Temperature;
    data['cmonoxide'] = this.Smoke;
    data['gas'] = this.Gas;
    data['humidity'] = this.AirHumidity;
    data['updateDate'] = this.UpdateDate;
    data['danger'] = this.Danger;
    return data;
  }
}
