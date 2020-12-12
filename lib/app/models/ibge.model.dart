class Estado {
  int id;
  String nome;
  String sigla;

  Estado({this.id, this.nome, this.sigla});
  Map<String, dynamic> toMap() {
    return {'id': id, 'nome': nome, 'sigla': sigla};
  }

  Estado.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      nome = json['nome'];
      sigla = json['sigla'];
    } catch (e) {
      print("Deu ruim ${e.toString()}");
    }
  }
}
