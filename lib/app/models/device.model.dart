class Device {
  late int idDevice;
  late String nome;
  late DateTime criadoEm;
  DateTime? desativadoEm;

  Device(
      {required this.idDevice,
      required this.nome,
      required this.criadoEm,
      this.desativadoEm,
      });

  Map<String, dynamic> toMap() {
    return {
      'id': idDevice,
      'mick': nome,
      'createdIn': criadoEm,
      'disabledIn': desativadoEm
    };
  }

  Device.fromJson(Map<String, dynamic> json) {
    idDevice = json['id'];
    nome = json['nick'];
    criadoEm =  DateTime.parse(json['createdIn']);
    desativadoEm = DateTime.parse(json['disabledIn']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nick'] = this.nome;
    data['id'] = this.idDevice;
    data['createdIn'] = this.criadoEm;
    data['disabledIn'] = this.desativadoEm;
    return data;
  }
}
