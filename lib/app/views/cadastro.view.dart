import 'package:flutter/material.dart';
import 'package:mvc_persistence/app/controllers/client.controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_persistence/app/models/client.model.dart';
import 'package:mvc_persistence/app/repositories/client.repository.dart';

class CadastroPage extends StatelessWidget {
  final _nome = TextEditingController();
  final _cpfCnpj = TextEditingController();
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _confirmaSenha = TextEditingController();
  final _logradouro = TextEditingController();
  final _numero = TextEditingController();
  final _bairro = TextEditingController();
  final _cidade = TextEditingController();
  final _estado = TextEditingController();
  final _cep = TextEditingController();
  var _controllerClient = ClientController();
  Client client;
  BuildContext _context;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
          title: Text(
            "Cadastro",
            style: TextStyle(color: Theme.of(context).primaryColorDark),
          )),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: _body(context),
      ),
    );
  }

  _body(BuildContext context) {
    print("cadastro");

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _editText("Nome", _nome, false),
          _editText("Cpf/Cnpj", _cpfCnpj, false),
          _editText("Email", _email, false),
          _editText("Senha", _senha, true),
          _editText("Confirma Senha", _confirmaSenha, true),
          _editText("CEP", _cep, false),
          _editText("Logradouro", _logradouro, false),
          _editText("Número", _numero, false),
          _editText("Bairro", _bairro, false),
          _editText("Cidade", _cidade, false),
          _editText("Estado", _estado, false),
          containerButton(context)
        ],
      ),
    );
  }

  _editText(String field, TextEditingController controller, bool inSenha) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        obscureText: inSenha,
        style: TextStyle(
          fontSize: 22,
          color: Theme.of(_context).primaryColor,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(_context).primaryColor)),
          labelText: field,
          labelStyle: TextStyle(
            fontSize: 18,
            color: Theme.of(_context).primaryColor,
          ),
        ),
      ),
    );
  }

  bool ValidateEmpty(Client client, final confirma_senha) {
    if (client.Nome == "" ||
        client.Email == "" ||
        client.Logradouro == "" ||
        client.Bairro == "" ||
        client.Cidade == "" ||
        client.Estado == "" ||
        client.Cep == "" ||
        client.CpfCnpj == "" ||
        client.Senha == "" ||
        client.Numero == null ||
        client.Senha != confirma_senha) {
      return false;
    } else
      return true;
  }

  Container containerButton(BuildContext context) {
    print("Terminou o cadastro");
    return Container(
      height: 40.0,
      margin: EdgeInsets.only(top: 10.0),
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        child: Text("Salvar",
            style: TextStyle(
                color: Theme.of(context).primaryColorDark, fontSize: 20.0)),
        onPressed: () {
          _onClickCadastro(context);
        },
      ),
    );
  }

  _onClickCadastro(BuildContext context) {
    print("vai salvar");
    print(_senha.text);
    print(_confirmaSenha.text);
    var num_teste;

    try {
      num_teste = int.parse(_numero.text);
    } catch (e) {
      num_teste = null;
    }
    client = new Client(
        IdClient: 0,
        Nome: _nome.text,
        Email: _email.text,
        Logradouro: _logradouro.text,
        Bairro: _bairro.text,
        Numero: num_teste,
        Cidade: _cidade.text,
        Estado: _estado.text,
        Cep: _cep.text,
        CpfCnpj: _cpfCnpj.text,
        Senha: _senha.text);
    print(client.toJson());
    if (ValidateEmpty(client, _confirmaSenha.text)) {
      _controllerClient.create(client);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(""),
              content: Text("Cliente cadastrado com sucesso!"),
              actions: <Widget>[
                FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    })
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Erro"),
              content: Text("Dados inválidos!"),
              actions: <Widget>[
                FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      //Navigator.of(context).pop();
                    })
              ],
            );
          });
    }
  }
}
