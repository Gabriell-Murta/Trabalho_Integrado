import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_persistence/app/controllers/client.controller.dart';
import 'package:mvc_persistence/app/models/client.model.dart';
import 'package:mvc_persistence/app/controllers/device.controller.dart';
import 'package:mvc_persistence/app/models/device.model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/device.model.dart';

class HomePage extends StatefulWidget {
  var _cliente = Client();
  var _listaDipositivo = List<Device>();
  HomePage(this._cliente,this._listaDipositivo);
  @override
  _HomePageState createState() => _HomePageState(_cliente,_listaDipositivo);
}

class DevicePanelItem {
  String ExpandedValue;
  String HeaderValue;
  bool IsExpanded;
  Device Item;

  DevicePanelItem(
      {this.ExpandedValue,
      this.HeaderValue,
      this.IsExpanded = false,
      this.Item});
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  var _textDeviceController = TextEditingController();
  var _clientController = ClientController();
  var _deviceController = DeviceController();
  var selectedDate = DateTime.now();
  var _cliente = Client();
  var _listaDipositivo = List<Device>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  //final SnackBar snackBar = const flutter_search_bar;
  var list_panel = List<DevicePanelItem>();

  _HomePageState(this._cliente,this._listaDipositivo);

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((value) {
      final _firstTime = value.getBool('firstTime') ?? true;
      if (_firstTime) {
        _displayFirstDialog(context);
        value.setBool('firstTime', false);
      }
    });

   setState(() {
     list_panel = generateDevicePanelItem();
    });
    //WidgetsBinding.instance.addPostFrameCallback((_) {
    //  _deviceController.getByLogin(_cliente.IdClient).then((data) {
    //    setState(() {
    //      _list = _deviceController.list;
    //      list_panel = generateDevicePanelItem();
    //    });
    //  });
    //});
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        title: Text('Dispositivos',
            style: TextStyle(color: Theme.of(context).primaryColorDark)),
        // actions: <Widget>[
        //   IconButton(
        //       icon: const Icon(Icons.search),
        //       tooltip: "Pesquisa",
        //       onPressed: () {})
        // ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Container(
          child: _buildDevicePanel(),
        ),
      ),
    );
  }

  List<DevicePanelItem> generateDevicePanelItem() {
    return List.generate(
        _listaDipositivo.length,
        (index) => DevicePanelItem(
            ExpandedValue:
                'ID: "${_listaDipositivo[index].Nome}"\nHASHASHSHASHASHAHSHASHAHSHSA: "${_listaDipositivo[index].Nome}"\nBATA_TESTE: "${_listaDipositivo[index].Nome}"',
            HeaderValue: _listaDipositivo[index].Nome,
            IsExpanded: false,
            Item: _listaDipositivo[index]));
  }

  Widget _buildDevicePanel() {
    if (_listaDipositivo.length == 0) {
      print("to aqui AAAAAAAAAAAAAA");
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Você ainda não possui dispositivos cadastrados.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30, color: Theme.of(context).primaryColor)),
          Text("Favor entrar em contato com comercial@tapegandofogo.br",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30, color: Theme.of(context).primaryColor))
        ],
      );
    }
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          list_panel[index].IsExpanded = !isExpanded;
        });
      },
      
    );
  }

  _displayFirstDialog(context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
              "Seja bem vindo! Parece que esta é a primeira vez que você abre este aplicativo! Através dele, você pode facilmente monitorar e visualizar seus dispositivos!"),
          actions: <Widget>[
            FlatButton(
              child: new Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
