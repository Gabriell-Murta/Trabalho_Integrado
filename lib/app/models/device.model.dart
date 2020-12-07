import 'package:mvc_persistence/app/models/medicao.model.dart';

class Device {
  int IdDevice;
  String Nick;
  int IdClient;
  String Latitude;
  String Longitude;
  List<Medicao> Measurements;

  Device(
      {this.IdDevice,
      this.Nick,
      this.IdClient,
      this.Latitude,
      this.Longitude,
      this.Measurements});

  Map<String, dynamic> toMap() {
    return {
      'IdDevice': IdDevice,
      'Nick': Nick,
      'IdClient': IdClient,
      'Latitude': Latitude,
      'Longitude': Longitude,
      'Measurements': Measurements
    };
  }

  Device.fromJson(Map<String, dynamic> json) {
    print(json['measurements']);
    Nick = json['nick'];
    IdDevice = json['idDevice'];
    IdClient = json['idClient'];
    Latitude = json['latitude'];
    Longitude = json['longitude'];
    // Measurements = json['measurements'].map((x) => Medicao.fromJson(x)).toList();
    List<Medicao> temp = [];
    json['measurements'].forEach((it) => {temp.add(Medicao.fromJson(it))});
    Measurements = temp;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Nick'] = this.Nick;
    data['IdClient'] = this.IdClient;
    data['IdDevice'] = this.IdDevice;
    data['Latitude'] = this.Latitude;
    data['Longitude'] = this.Longitude;
    data['Measurements'] = this.Measurements;
    return data;
  }
}
