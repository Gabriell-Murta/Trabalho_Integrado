class Client {
  int? idClient;
  String? nome;
  String? email;
  String? logradouro;
  String? bairro;
  int? numero;
  String? cidade;
  String? estado;
  String? cpfCnpj;
  String? senha;
  String? cep;
  DateTime? criadoEm;

  Client({this.idClient, this.nome, this.email, this.logradouro, this.bairro, this.numero, this.cidade, this.estado, this.cpfCnpj, this.senha,this.cep,this.criadoEm});

  Map<String, dynamic> toMap() {
    return {
      
        'name':nome,
        'clientId':idClient,
        'email':email,
        'address':logradouro,
        'district':bairro,
        'number':numero,
        'city':cidade,
        'uf':estado,
        'postalCode':cep,
        'cpf':cpfCnpj,
        'password':senha,
        'createdIn': criadoEm
    };
  }
  
  Client.fromJson(Map<String, dynamic> json) {
    nome = json['name'];
    idClient = json['clientId'];
    email = json['email'];
    logradouro = json['address'];
    bairro = json['district'];
    numero = json['number'];
    cidade = json['city'];
    estado = json['uf'];
    cpfCnpj = json['cpf'];
    senha = json['password'];
    criadoEm = json['createdIn'];
    cep = json['postalCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.nome;
    data['clientId'] = this.idClient;
    data['email'] = this.email;
    data['address'] = this.logradouro;
    data['district'] = this.bairro;
    data['number'] = this.numero;
    data['city'] = this.cidade;
    data['uf'] = this.estado;
    data['cpf'] = this.cpfCnpj;
    data['password'] = this.senha;
    data['createdIn'] = this.criadoEm;
    data['postalCode'] = this.cep;
    return data;
  }
}