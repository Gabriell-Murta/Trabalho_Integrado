import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:mvc_persistence/app/views/cadastroDispositivo.view.dart';
import 'package:path/path.dart';
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
  List<Device> _listaDispositivo = [];
  HomePage(this._cliente,this._listaDispositivo);
  @override
  _HomePageState createState() => _HomePageState(_cliente,_listaDispositivo);
}

class DevicePanelItem {
  String headerValue;
  bool isExpanded;
  Device item;

  DevicePanelItem(
      {required this.headerValue,
      this.isExpanded = false,
      required this.item});
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textDeviceController = TextEditingController();
  ClientController _clientController = ClientController();
  DeviceController _deviceController = DeviceController();
  DateTime selectedDate = DateTime.now();
  Client _cliente = Client();
  List<Device> _listaDispositivo = [];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  //final SnackBar snackBar = const flutter_search_bar;
  List<DevicePanelItem> list_panel = [];

  _HomePageState(this._cliente,this._listaDispositivo);

  @override
  void initState() {
    super.initState();
    BleManager bluetooth = BleManager();
    bluetooth.createClient();
    bluetooth.enableRadio();
    bluetooth.bluetoothState().then((value) {
      bluetooth.observeBluetoothState().listen((event) {
        print(event);
        bluetooth.startPeripheralScan(
          // uuids: [
          //   "F000AA00-0451-4000-B000-000000000000",
          // ],
        ).listen((scanResult) {
          print("Scanned Peripheral ${scanResult.peripheral.name}, RSSI ${scanResult.rssi}");
          //bluetooth.stopPeripheralScan();
        });
      });
    });



    // bluetooth.destroyClient();

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
          child: _buildDevicePanel(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context) => CadastroDispositivo(_cliente,_listaDispositivo))).whenComplete(() => {
            _deviceController.getByLogin(_cliente.idClient).then((value) => 
              setState(() {
                _listaDispositivo = _deviceController.list;
                list_panel = generateDevicePanelItem();
              })
            )
          });
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
            headerValue: _listaDispositivo[index].nome,
            isExpanded: false,
            item: _listaDispositivo[index]));
  }

  Widget _buildDevicePanel(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          list_panel[index].isExpanded = !isExpanded;
        });
      },
      children: list_panel.map<ExpansionPanel>((DevicePanelItem devicePanelItem){
        return ExpansionPanel(
          backgroundColor: Colors.black,
          headerBuilder: (BuildContext context, bool isExpanded){
            return ListTile(
              title: Text(devicePanelItem.headerValue),
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
          isExpanded: devicePanelItem.isExpanded,
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
              "Seja bem vindo! Parece que esta é a primeira vez que você" 
              + "abre este aplicativo! Através dele, você pode facilmente" + 
              " monitorar e visualizar seus dispositivos!"),
          actions: <Widget>[
            TextButton(
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
