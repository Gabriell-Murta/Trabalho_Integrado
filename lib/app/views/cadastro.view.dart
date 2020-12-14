import 'package:flutter/material.dart';
import 'package:mvc_persistence/app/controllers/client.controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_persistence/app/controllers/ibge.controller.dart';
import 'package:mvc_persistence/app/models/client.model.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mvc_persistence/app/models/ibge.model.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _nome = TextEditingController();
  final _cpfCnpj = TextEditingController();
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _confirmaSenha = TextEditingController();
  final _logradouro = TextEditingController();
  final _numero = TextEditingController();
  final _bairro = TextEditingController();
  final _cidade = TextEditingController();
  var _estado = TextEditingController();
  final _telefone = TextEditingController();
  var _controllerClient = ClientController();
  Client client;
  BuildContext _context;
  List<Estado> _listaEstado = List<Estado>();

  final _maskCpfCnpj = new MaskTextInputFormatter(
      mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
  final _maskTelefone = new MaskTextInputFormatter(
      mask: '(##) # ####-####', filter: {'#': RegExp(r'[0-9]')});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _estado.text = "AC";
    // setState(() {
    var _controller = EstadoController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _listaEstado = [new Estado(id: 1, nome: 'Minas', sigla: 'MG')];
      _controller.getEstados().then((data) => {
            setState(() {
              _listaEstado = _controller.list;
            })
          });
    });
    // });
  }

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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _editText("Nome", _nome, false),
          _editText("Cpf/Cnpj", _cpfCnpj, false),
          _editText("Email", _email, false),
          _editText("Senha", _senha, true),
          _editText("Confirma Senha", _confirmaSenha, true),
          _editText("Telefone", _telefone, false),
          _dropDownFieldEstado("Estado", _estado),
          _editText("Cidade", _cidade, false),
          _editText("Bairro", _bairro, false),
          _editText("Logradouro", _logradouro, false),
          _editText("Número", _numero, false),
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
        inputFormatters: field == 'Cpf/Cnpj'
            ? [_maskCpfCnpj]
            : field == 'Telefone'
                ? [_maskTelefone]
                : field == 'Número'
                    ? [new MaskTextInputFormatter(mask: '#####')]
                    : [],
        onChanged: (value) {
          if (field == 'Cpf/Cnpj') {
            if (value.length < 14) {
              _maskCpfCnpj.updateMask(mask: "###.###.###-##");
            } else {
              _maskCpfCnpj.updateMask(mask: "##.###.###/####-##");
            }
          }
        },
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

  _dropDownFieldEstado(String field, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InputDecorator(
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
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: _estado.text,
              isDense: true,
              onChanged: (String newValue) {
                setState(() {
                  _estado.text = newValue;
                  // state.didChange(newValue);
                });
              },
              items: _listaEstado.map((value) {
                return DropdownMenuItem(
                  value: value.sigla,
                  child: Text(value.sigla),
                );
              }).toList(),
            ),
          )),
    );
  }

  bool ValidateEmpty(Client client, final confirma_senha) {
    if (client.Nome == "" ||
        client.Email == "" ||
        client.Logradouro == "" ||
        client.Bairro == "" ||
        client.Cidade == "" ||
        client.Estado == "" ||
        client.Telefone == "" ||
        client.CpfCnpj == "" ||
        client.Senha == "" ||
        client.Numero == null ||
        client.Senha != confirma_senha) {
      return false;
    } else
      return true;
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
          _onClickCadastro(context);
        },
      ),
    );
  }

  _onClickCadastro(BuildContext context) async {
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
        Telefone: _telefone.text,
        CpfCnpj: _cpfCnpj.text,
        Senha: _senha.text);
    if (ValidateEmpty(client, _confirmaSenha.text)) {
      var createReturn = await _controllerClient.Create(client);

      if (createReturn == 1) {
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
      }
      if (createReturn == 2) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Erro"),
                content: Text("Credenciais já em uso!"),
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
      }
      if (createReturn == 3) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Erro"),
                content: Text(
                    "Impossível cadastrar o cliente!\nTente novamente mais tarde."),
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
      }
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
