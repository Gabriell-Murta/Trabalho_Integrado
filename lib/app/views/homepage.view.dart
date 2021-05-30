import '../models/device.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_persistence/app/controllers/client.controller.dart';
import 'package:mvc_persistence/app/controllers/device.controller.dart';
import 'package:mvc_persistence/app/models/client.model.dart';
import 'package:mvc_persistence/app/models/device.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  Client _cliente = Client();
  List<Device> _listaDispositivo = List<Device>.empty();
  HomePage(this._cliente,this._listaDispositivo);
  @override
  _HomePageState createState() => _HomePageState(_cliente,_listaDispositivo);
}

class DevicePanelItem {
  String HeaderValue;
  bool IsExpanded;
  Device Item;

  DevicePanelItem(
      {this.HeaderValue,
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
  var _listaDispositivo = List<Device>.empty();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  //final SnackBar snackBar = const flutter_search_bar;
  var list_panel = List<DevicePanelItem>.empty();

  _HomePageState(this._cliente,this._listaDispositivo);

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
        child: Container(
          child:  _buildDevicePanel(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: const Icon(Icons.add_circle_outline),
        backgroundColor: Colors.purple,
      ),
    );
  }

  List<DevicePanelItem> generateDevicePanelItem() {
    return List.generate(
        _listaDispositivo.length,
        (index) => DevicePanelItem(
            HeaderValue: _listaDispositivo[index].Nome,
            IsExpanded: false,
            Item: _listaDispositivo[index]));
  }

  Widget _buildDevicePanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          list_panel[index].IsExpanded = !isExpanded;
        });
      },
      children: list_panel.map<ExpansionPanel>((DevicePanelItem devicePanelItem){
        return ExpansionPanel(
          //backgroundColor: Colors.purple,
          headerBuilder: (BuildContext context, bool isExpanded){
            return ListTile(
              title: Text(devicePanelItem.HeaderValue),
            );
          },
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buttonConnect(),
                _buttonSwitch(),
              ],
            ),
          ),
          isExpanded: devicePanelItem.IsExpanded,
        );
      }).toList(),
    );
  }

  Widget _buttonConnect(){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        onSurface: Colors.blue,
        ),
      onPressed: null,
      child: const Text("Conectar"),
    );
  }

  Widget _buttonSwitch(){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        onSurface: Colors.green[200],
        ),
      onPressed: null,
      child: const Text("Abrir"),
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
