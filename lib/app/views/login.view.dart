import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_persistence/app/views/homepage.view.dart';

import 'cadastro.view.dart';
// import 'package:mvc_persistence/app/controllers/client.controller.dart';
// import 'package:mvc_persistence/app/models/client.model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../models/client.model.dart';
// import 'package:mvc_persistence/app/views/login.view.dart';

// import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final _tedLogin = TextEditingController();
  final _tedSenha = TextEditingController();
  BuildContext _context;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tá Pegando Fogo Bicho",
          style: TextStyle(color: Theme.of(context).primaryColorDark),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _body(context),
      ),
    );
  }

  String _validaInput(String text, String field) {
    if (text.isEmpty) {
      return "Campo obrigatório";
    }
    return null;
  }
  // String _validaLogin(String text) {
  //   if (text.isEmpty) {
  //     return "Informe o CPF";
  //   }
  //   return null;
  // }

  // String _validaSenha(String text) {
  //   if (text.isEmpty) {
  //     return "Informe a senha";
  //   }
  //   return null;
  // }

  _body(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            _textFormField("Cpf/Cnpj", _tedLogin),
            _textFormField("Senha", _tedSenha),
            containerButton(context, "Entrar", true),
            containerButton(context, "Cadastrar", false)
          ],
        ));
  }

  _textFormField(String field, TextEditingController controller) {
    return TextFormField(
        controller: controller,
        obscureText: field == "Senha",
        validator: (s) => _validaInput(s, field),
        keyboardType: TextInputType.text,
        style: TextStyle(color: Theme.of(_context).primaryColor),
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(_context).primaryColor)),
            labelText: field,
            labelStyle: TextStyle(
                fontSize: 20.0, color: Theme.of(_context).primaryColor),
            hintText: "Informe o $field"));
  }

  // TextFormField textFormFieldLogin() {
  //   return TextFormField(
  //       controller: _tedLogin,
  //       validator: _validaLogin,
  //       keyboardType: TextInputType.text,
  //       style: TextStyle(color: Colors.red[900]),
  //       decoration: InputDecoration(
  //           enabledBorder: UnderlineInputBorder(
  //               borderSide: BorderSide(color: Colors.red[900])),
  //           labelText: "Login",
  //           labelStyle: TextStyle(fontSize: 20.0, color: Colors.red[900]),
  //           hintText: "Informe a senha"));
  // }

  Container containerButton(BuildContext context, String title, bool inLogin) {
    return Container(
      height: 40.0,
      margin: EdgeInsets.only(top: 10.0),
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        child: Text(title,
            style: TextStyle(
                color: Theme.of(context).primaryColorDark, fontSize: 20.0)),
        onPressed: () {
          if (inLogin)
            _onClickLogin(context);
          else
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CadastroPage()));
        },
      ),
    );
  }

  // TextFormField textFormFieldSenha() {
  //   return TextFormField(
  //       controller: _tedSenha,
  //       validator: _validaSenha,
  //       obscureText: true,
  //       keyboardType: TextInputType.text,
  //       style: TextStyle(color: Colors.red[900]),
  //       decoration: InputDecoration(
  //           labelText: "Senha",
  //           labelStyle: TextStyle(fontSize: 20.0, color: Colors.red[900]),
  //           hintText: "Informe a senha"));
  // }

  _onClickLogin(BuildContext context) {
    final login = _tedLogin.text;
    final senha = _tedSenha.text;

    print("Login: $login , Senha: $senha ");

    if (!_formKey.currentState.validate()) {
      return;
    }

    if (login.isEmpty || senha.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Erro"),
              content: Text("Login e/ou Senha inválido(s)"),
              actions: <Widget>[
                FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ]);
        },
      );
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }
}
