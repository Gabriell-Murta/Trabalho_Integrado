import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_persistence/app/controllers/client.controller.dart';
import 'package:mvc_persistence/app/models/client.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/client.model.dart';
import 'package:mvc_persistence/app/views/login.view.dart';


import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  final _tedLogin = TextEditingController();
  final _tedSenha = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fazer Login"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _body(context),
      ),
    );
  }

  String _validaLogin(String text){
    if(text.isEmpty){
      return "Informe o CPF";
    }
    return null;
  }

  String _validaSenha(String text){
    if(text.isEmpty){
      return "Informe a senha";
    }
    return null;
  }

  _body(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            textFormFieldLogin(),
            textFormFieldSenha(),
            containerButton(context)
          ],
        )
    );
  }

  TextFormField textFormFieldLogin() {
    return TextFormField(
        controller: _tedLogin,
        validator: _validaLogin,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            labelText: "Login",
            labelStyle: TextStyle(fontSize:20.0, color: Colors.black),
            hintText: "Informe a senha"
        )
    );
  }

  Container containerButton(BuildContext context) {
    return Container(
      height: 40.0,
      margin: EdgeInsets.only(top: 10.0),
      child: RaisedButton(
        color: Colors.blue,
        child: Text("Login",
            style: TextStyle(color: Colors.white, fontSize: 20.0)),
        onPressed: () { _onClickLogin(context); },
      ),
    );
  }

  TextFormField textFormFieldSenha() {
    return TextFormField(
        controller: _tedSenha,
        validator: _validaSenha,
        obscureText: true,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            labelText: "Senha",
            labelStyle: TextStyle(fontSize:20.0, color: Colors.black),
            hintText: "Informe a senha"
        )
    );
  }

  _onClickLogin(BuildContext context) {
    final login = _tedLogin.text;
    final senha = _tedSenha.text;

    print("Login: $login , Senha: $senha " );

    if(!_formKey.currentState.validate())  {
      return;
    }

    if(login.isEmpty || senha.isEmpty) {
      showDialog(context: context,
        builder: (context){
          return AlertDialog(
              title:Text("Erro"),
              content: Text("Login e/ou Senha inválido(s)"),
              actions : <Widget>[
                FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    }
                )
              ]
          );
        },
      );
    }
  }
}