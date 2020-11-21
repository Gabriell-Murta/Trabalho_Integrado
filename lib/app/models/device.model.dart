class Device {
  int IdDevice;
  String Nick;
  int IdClient;
  String Location;

  Device({this.IdDevice, this.Nick, this.IdClient, this.Location});

  Map<String, dynamic> toMap() {
    return {
      'IdDevice': IdDevice,
      'Nick': Nick,
      'IdClient': IdClient,
      'Location': Location,
    };
  }
  Device.fromJson(Map<String, dynamic> json) {
    Nick = json['Nick'];
    IdDevice = json['IdDevice'];
    IdClient = json['IdClient'];
    Location = json['Location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Nick'] = this.Nick;
    data['IdClient'] = this.IdClient;
    data['IdDevice'] = this.IdDevice;
    data['Location'] = this.Location;
    return data;
  }
}
