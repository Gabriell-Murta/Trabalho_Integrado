import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_persistence/app/controllers/device.controller.dart';
import 'package:mvc_persistence/app/models/device.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/device.model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
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
  var _list = List<Device>();
  var _controller = DeviceController();
  var selectedDate = DateTime.now();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  //final SnackBar snackBar = const flutter_search_bar;
  var list_panel = List<DevicePanelItem>();
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getTeste().then((data) {
        setState(() {
          _list = _controller.list;
        });

        list_panel=generateDevicePanelItem();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('DISPOSITIVOS'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.search),
              tooltip: "Pesquisa",
              onPressed: () {})
        ],
      ),
      // body: Scrollbar(
      //   child: ListView(
      //     children: [for (int i = 0; i < _list.length; i++) DeviceList()],
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Container(
          child: _buildDevicePanel(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _displayDialog(context),
      ),
    );
  }


  List<DevicePanelItem> generateDevicePanelItem(){
    return List.generate(
      _list.length,
            (index) => DevicePanelItem(
            ExpandedValue:
            'Dispositivo localizado em "${_list[index].Nick}"',
            HeaderValue: _list[index].Nick,
            Item: _list[index]));
  }

  Widget _buildDevicePanel() {

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
            ),
            isExpanded: item.IsExpanded);
      }).toList(),
    );
  }

  _displayDialog(context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _deviceController,
                  validator: (s) {
                    if (s.isEmpty)
                      return "Digite o dispositivo.";
                    else
                      return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration:
                      InputDecoration(labelText: "Nome do Dispositivo:"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: new Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text('SALVAR'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _controller
                      .create(Device(
                    Nick: _deviceController.text,
                    IdDevice: 0,
                    Location: "",
                    IdClient: 0,
                  ))
                      .then((data) {
                    setState(() {
                      _list = _controller.list;
                      _deviceController.text = "";
                    });
                  });
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        );
      },
    );
  }

  _displayFirstDialog(context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
              "Seja bem vindo! Parece que esta é a primeira vez que você abre este aplicativo! Através dele, você pode facilmente monitorar seus dispositivos, tocando no botão no canto inferior da tela!"),
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
