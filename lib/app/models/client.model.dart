class Client {
  int IdClient;
  String Nome;
  String Email;
  String Logradouro;
  String Bairro;
  int Numero;
  String Cidade;
  String Estado;
  String Telefone;
  String CpfCnpj;
  String Senha;


  Client({this.IdClient, this.Nome, this.Email, this.Logradouro, this.Bairro, this.Numero, this.Cidade, this.Estado, this.Telefone, this.CpfCnpj, this.Senha});

  Map<String, dynamic> toMap() {
    return {
      'IdClient': IdClient,
      'Nome': Nome,
      'Email': Email,
      'Logradouro': Logradouro,
      'Bairro': Bairro,
      'Numero': Numero,
      'Cidade': Cidade,
      'Estado': Estado,
      'Telefone': Telefone,
      'CpfCnpj': CpfCnpj,
      'Senha': Senha,
    };
  }
  Client.fromJson(Map<String, dynamic> json) {
    Nome = json['Nome'];
    IdClient = json['IdClient'];
    Email = json['Email'];
    Logradouro = json['Logradouro'];
    Bairro = json['Bairro'];
    Numero = json['Numero'];
    Cidade = json['Cidade'];
    Estado = json['Estado'];
    Telefone = json['Telefone'];
    CpfCnpj = json['CpfCnpj'];
    Senha = json['Senha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Nome'] = this.Nome;
    data['IdClient'] = this.IdClient;
    data['Email'] = this.Email;
    data['Logradouro'] = this.Logradouro;
    data['Bairro'] = this.Bairro;
    data['Numero'] = this.Numero;
    data['Cidade'] = this.Cidade;
    data['Estado'] = this.Estado;
    data['Telefone'] = this.Telefone;
    data['CpfCnpj'] = this.CpfCnpj;
    data['Senha'] = this.Senha;

    return data;
  }
}