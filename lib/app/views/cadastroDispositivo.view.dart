import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_persistence/app/controllers/device.controller.dart';
import 'package:mvc_persistence/app/models/client.model.dart';
import 'package:mvc_persistence/app/models/device.model.dart';

class CadastroDispositivo extends StatelessWidget {
  final _nome = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _controllerDevice = DeviceController();
  Client _client = Client();
  List<Device> _devices = List.empty();

  CadastroDispositivo(this._client, this._devices);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        title: Text(
          'Cadastro Dispositivo',
          style: TextStyle(color: Theme.of(context).primaryColorDark),
        ),
      ),
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
          _editText("Nome", _nome, false,context),
          containerButton(context)
        ],
      ),
    );
  }

  _editText(String field, TextEditingController controller, bool inSenha, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        obscureText: inSenha,
        style: TextStyle(
          fontSize: 22,
          color: Theme.of(context).primaryColor,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          labelText: field,
          labelStyle: TextStyle(
            fontSize: 18,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  bool validateEmpty(String name, final confirmaSenha) {
    if (name == "" || _devices.any((device) => device.nome == name )) {
      return false;
    } else
      return true;
  }

  Container containerButton(BuildContext context) {
    return Container(
      height: 40.0,
      margin: EdgeInsets.only(top: 10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
        child: Text("Salvar",
            style: TextStyle(
                color: Theme.of(context).primaryColorDark, fontSize: 20.0)),
        onPressed: () {
          _onClickCadastro(context);
        },
      ),
    );
  }

  _onClickCadastro(BuildContext context) async {
    await _controllerDevice.create(_nome.text, _client.idClient);
    await _controllerDevice.getByLogin(_client.idClient);
    
    if(_controllerDevice.list.any((device) => device.nome.trim().toUpperCase() == _nome.text.trim().toUpperCase())){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(""),
            content: Text("Dispositivo cadastrado com sucesso!"),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }
              )
            ],
          );
        }
      );
    }
    else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(""),
            content: Text("Não foi cadastrado seu arrombado!"),
            actions: <Widget>[
              TextButton(
                child: Text("BLZ"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }
              )
            ],
          );
        }
      );
    }
  }
}
