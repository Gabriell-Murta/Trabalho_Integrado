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
  /*Item.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    concluido = json['concluido'];
    dueDate = DateTime.parse(json['dueDate']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['concluido'] = this.concluido;
    data['dueDate'] = this.dueDate.toIso8601String();
    return data;
  }*/
}
