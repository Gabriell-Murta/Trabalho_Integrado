import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _maskCpfCnpj = new MaskTextInputFormatter(
      mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
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

  // List<TextInputFormatter> _inputMask(String field, String text) {
  //   print(text);
  //   if (field == 'senha')
  //     return [];
  //   else if (text.length < 13)
  //     return _maskCpf;
  //   else
  //     return _maskCnpj;
  // }

  _textFormField(String field, TextEditingController controller) {
    return TextFormField(
        controller: controller,
        obscureText: field == "Senha",
        validator: (s) => _validaInput(s, field),
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 22, color: Theme.of(_context).primaryColor),
        inputFormatters: field == 'Senha' ? [] : [_maskCpfCnpj],
        onChanged: (value) {
          if (field != 'Senha') {
            if (value.length < 14) {
              _maskCpfCnpj.updateMask(mask: "###.###.###-##");
            } else {
              _maskCpfCnpj.updateMask(mask: "##.###.###/####-##");
            }
          }
        },
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
      var _controller = DeviceController();
      var _list = List<Device>();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.getByLogin(login, senha).then((data) {
          setState(() {
            print("aquiii");
            _list = _controller.list;
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomePage(_list)));
          });
        }).catchError((onError) {
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
                        })
                  ],
                );
              });
        });
      });
    }
  }
}
