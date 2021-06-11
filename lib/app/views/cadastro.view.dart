import 'package:flutter/material.dart';
import 'package:mvc_persistence/app/controllers/client.controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_persistence/app/models/client.model.dart';

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
  final ClientController _controllerClient = ClientController();
  late Client client;
  late BuildContext _context;
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

  bool validateEmpty(Client client, final confirmaSenha) {
    if (client.nome == "" ||
        client.email == "" ||
        client.logradouro == "" ||
        client.bairro == "" ||
        client.cidade == "" ||
        client.estado == "" ||
        client.cep == "" ||
        client.cpfCnpj == "" ||
        client.senha == "" ||
        client.numero == null ||
        client.senha != confirmaSenha) {
      return false;
    } else
      return true;
  }

  Container containerButton(BuildContext context) {
    print("Terminou o cadastro");
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

  _onClickCadastro(BuildContext context) {
    print("vai salvar");
    print(_senha.text);
    print(_confirmaSenha.text);

    int? numTeste;

    try {
      numTeste = int.parse(_numero.text);
    } catch (e) {
      numTeste = null;
    }
    client = new Client(
        idClient: 0,
        nome: _nome.text,
        email: _email.text,
        logradouro: _logradouro.text,
        bairro: _bairro.text,
        numero: numTeste,
        cidade: _cidade.text,
        estado: _estado.text,
        cep: _cep.text,
        cpfCnpj: _cpfCnpj.text,
        senha: _senha.text);
    print(client.toJson());
    if (validateEmpty(client, _confirmaSenha.text)) {
      _controllerClient.create(client);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(""),
              content: Text("Cliente cadastrado com sucesso!"),
              actions: <Widget>[
                TextButton(
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
              TextButton(
                child: Text("OK"),
                onPressed: () {
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
