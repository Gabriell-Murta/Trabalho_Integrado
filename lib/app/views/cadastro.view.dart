import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  final _telefone = TextEditingController();
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
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _editText("Nome", _nome, false),
          _editText("Cpf/Cnpj", _cpfCnpj, false),
          _editText("Email", _email, false),
          _editText("Senha", _senha, true),
          _editText("Confirma Senha", _confirmaSenha, true),
          _editText("Telefone", _telefone, false),
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
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      obscureText: inSenha,
      style: TextStyle(
        fontSize: 22,
        color: Theme.of(_context).primaryColor,
      ),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(_context).primaryColor)),
        labelText: field,
        labelStyle: TextStyle(
          fontSize: 22,
          color: Theme.of(_context).primaryColor,
        ),
      ),
    );
  }

  String _validate(String text, String field) {
    if (text.isEmpty) {
      return "Digite $field";
    }
    return null;
  }

  Container containerButton(BuildContext context) {
    return Container(
      height: 40.0,
      margin: EdgeInsets.only(top: 10.0),
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        child: Text("Salvar",
            style: TextStyle(
                color: Theme.of(context).primaryColorDark, fontSize: 20.0)),
        onPressed: () {
          _onClickCadastro();
        },
      ),
    );
  }

  _onClickCadastro() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    Client cli = new Client(
        IdClient: 0,
        Nome: _nome.text,
        Email: _email.text,
        Logradouro: _logradouro.text,
        Bairro: _bairro.text,
        Numero: int.parse(_numero.text),
        Cidade: _cidade.text,
        Estado: _estado.text,
        Telefone: _telefone.text,
        CpfCnpj: _cpfCnpj.text,
        Senha: _senha.text);

    ClientRepository().create(cli);
  }
}
