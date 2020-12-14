import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_persistence/app/controllers/device.controller.dart';
import 'package:mvc_persistence/app/models/device.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/device.model.dart';
import 'medicao.view.dart';

class HomePage extends StatefulWidget {
  var _list = List<Device>();
  HomePage(this._list);
  @override
  _HomePageState createState() => _HomePageState(_list);
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
  var _deviceController = TextEditingController();
  var _controller = DeviceController();
  var selectedDate = DateTime.now();
  var _list = List<Device>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  //final SnackBar snackBar = const flutter_search_bar;
  var list_panel = List<DevicePanelItem>();

  _HomePageState(this._list);

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
        _list.length,
        (index) => DevicePanelItem(
            ExpandedValue:
                'ID: "${_list[index].IdDevice}"\nLatitude: "${_list[index].Latitude}"\nLongitude: "${_list[index].Longitude}"',
            HeaderValue: _list[index].Nick,
            IsExpanded: false,
            Item: _list[index]));
  }

  Widget _buildDevicePanel() {
    if (_list.length == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Você ainda não possui dispositivos cadastrados.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30, color: Theme.of(context).primaryColor)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "Favor entrar em contato com comercial@tapegandofogo.br",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 26, color: Theme.of(context).primaryColor)),
          )
        ],
      );
    }
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          list_panel[index].IsExpanded = !isExpanded;
        });
      },
      children: list_panel.map<ExpansionPanel>((DevicePanelItem item) {
        return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(item.HeaderValue),
              );
            },
            body: ListTile(
                title: Text(item.ExpandedValue),
                trailing: FlatButton(
                    // icon: Icon(Icons.details),
                    textColor: Theme.of(context).primaryColor,
                    child: Text("Ver medições"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MedicaoPage(item.Item.Measurements)));
                    })),
            isExpanded: item.IsExpanded);
      }).toList(),
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
