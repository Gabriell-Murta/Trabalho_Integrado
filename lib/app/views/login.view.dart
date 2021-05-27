import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_persistence/app/controllers/client.controller.dart';
import 'package:mvc_persistence/app/models/client.model.dart';
import 'package:mvc_persistence/app/controllers/device.controller.dart';
import 'package:mvc_persistence/app/models/device.model.dart';
import 'package:mvc_persistence/app/views/homepage.view.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'cadastro.view.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  _body(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _textFormField("Cpf/Cnpj", _tedLogin),
            _textFormField("Senha", _tedSenha),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                containerButton(context, "Cadastrar", false),
                containerButton(context, "Entrar", true)
              ],
            )
          ],
        ));
  }

  _textFormField(String field, TextEditingController controller) {
    return TextFormField(
        // inputFormatters: new MaskTextInputFormatter(mask: ),
        controller: controller,
        obscureText: field == "Senha",
        validator: (s) => _validaInput(s, field),
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 22, color: Theme.of(_context).primaryColor),
        decoration: InputDecoration(
            // contentPadding: const EdgeInsets.all(20.0),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(_context).primaryColor)),
            labelText: field,
            labelStyle: TextStyle(
                fontSize: 22.0, color: Theme.of(_context).primaryColor),
            hintText: "Informe o $field"));
  }

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

  _onClickLogin(BuildContext context) {
    final cpf = _tedLogin.text;
    final senha = _tedSenha.text;

    print("Login: $cpf , Senha: $senha ");

    if (!_formKey.currentState.validate()) {
      return;
    }

    if (cpf.isEmpty || senha.isEmpty) {
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
      var _controller = ClientController();
      var _client = Client();
      var _device = List<Device>();
      var _deviceController = DeviceController();
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        try{
          await _controller.getByLogin(cpf, senha);
          print("aquiii");
          if(_controller.cliente.CpfCnpj == null)
          {
            throw new Exception();
          }
          _client = _controller.cliente;
          await _deviceController.getByLogin(_client.IdClient);
          _device = _deviceController.list;
          Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage(_client,_device)));
        }catch(ex){
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Erro ao fazer login"),
                  content: Text("Confira seu CPF/CNPJ e a sua senha!"),
                  actions: <Widget>[
                    FlatButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          //Navigator.of(context).pop();
                        },),
                  ],
                );
              },);
        }
      },);
    }
  }
}
