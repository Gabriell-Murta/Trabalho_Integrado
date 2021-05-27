class Client {
  int IdClient;
  String Nome;
  String Email;
  String Logradouro;
  String Bairro;
  int Numero;
  String Cidade;
  String Estado;
  String CpfCnpj;
  String Senha;
  String Cep;
  DateTime Criado_em;


  Client({this.IdClient, this.Nome, this.Email, this.Logradouro, this.Bairro, this.Numero, this.Cidade, this.Estado, this.CpfCnpj, this.Senha,this.Cep,this.Criado_em});

  Map<String, dynamic> toMap() {
    return {
      
        'name':Nome,
        'clientId':IdClient,
        'email':Email,
        'address':Logradouro,
        'district':Bairro,
        'number':Numero,
        'city':Cidade,
        'uf':Estado,
        'postalCode':Cep,
        'cpf':CpfCnpj,
        'password':Senha,
        'createdIn': Criado_em
    };
  }
  Client.fromJson(Map<String, dynamic> json) {
    Nome = json['name'];
    IdClient = json['clientId'];
    Email = json['email'];
    Logradouro = json['address'];
    Bairro = json['district'];
    Numero = json['number'];
    Cidade = json['city'];
    Estado = json['uf'];
    CpfCnpj = json['cpf'];
    Senha = json['password'];
    Criado_em = json['createdIn'];
    Cep = json['postalCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.Nome;
    data['clientId'] = this.IdClient;
    data['email'] = this.Email;
    data['address'] = this.Logradouro;
    data['district'] = this.Bairro;
    data['number'] = this.Numero;
    data['city'] = this.Cidade;
    data['uf'] = this.Estado;
    data['cpf'] = this.CpfCnpj;
    data['password'] = this.Senha;
    data['createdIn'] = this.Criado_em;
    data['postalCode'] = this.Cep;
    return data;
  }
}