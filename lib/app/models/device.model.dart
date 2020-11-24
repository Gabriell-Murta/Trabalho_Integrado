class Device {
  int IdDevice;
  String Nick;
  int IdClient;
  String Latitude;
  String Longitude;

  Device({this.IdDevice, this.Nick, this.IdClient, this.Latitude, this.Longitude});

  Map<String, dynamic> toMap() {
    return {
      'IdDevice': IdDevice,
      'Nick': Nick,
      'IdClient': IdClient,
      'Latitude': Latitude,
      'Longitude': Longitude,
    };
  }
  Device.fromJson(Map<String, dynamic> json) {
    Nick = json['nick'];
    IdDevice = json['idDevice'];
    IdClient = json['idClient'];
    Latitude = json['latitude'];
    Longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Nick'] = this.Nick;
    data['IdClient'] = this.IdClient;
    data['IdDevice'] = this.IdDevice;
    data['Latitude'] = this.Latitude;
    data['Longitude'] = this.Longitude;
    return data;
  }
}
