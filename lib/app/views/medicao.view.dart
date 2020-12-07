import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mvc_persistence/app/controllers/device.controller.dart';
import 'package:mvc_persistence/app/models/device.model.dart';
import 'package:mvc_persistence/app/models/medicao.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/device.model.dart';

class MedicaoPage extends StatefulWidget {
  var _list = List<Medicao>();
  MedicaoPage(this._list);
  @override
  _MedicaoPageState createState() => _MedicaoPageState(_list);
}

class MedicaoPanelItem {
  String ExpandedValue;
  String HeaderValue;
  bool IsExpanded;

  MedicaoPanelItem(
      {this.ExpandedValue, this.HeaderValue, this.IsExpanded = false});
}

class _MedicaoPageState extends State<MedicaoPage> {
  var selectedDate = DateTime.now();
  var _list = List<Medicao>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  //final SnackBar snackBar = const flutter_search_bar;
  var list_panel = List<MedicaoPanelItem>();

  _MedicaoPageState(this._list);

  @override
  void initState() {
    super.initState();

    // initializeDateFormatting('pt_BR', null).then((_) => {});

    setState(() {
      list_panel = generateMedicaoPanelItem();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        title: Text('Medições',
            style: TextStyle(color: Theme.of(context).primaryColorDark)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: _buildDevicePanel(),
        ),
      ),
    );
  }

  List<MedicaoPanelItem> generateMedicaoPanelItem() {
    return List.generate(
        _list.length,
        (index) => MedicaoPanelItem(
            ExpandedValue:
                'ID: ${_list[index].IdMedicao}\nTemperatura: ${_list[index].Temperature}° C\nFumaça: ${_list[index].Smoke}\nGás: ${_list[index].Gas}\nUmidade: ${_list[index].AirHumidity}\nRisco: ${_list[index].Danger}',
            HeaderValue: 'data'));
  }

  Widget _buildDevicePanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          list_panel[index].IsExpanded = !isExpanded;
        });
      },
      children: list_panel.map<ExpansionPanel>((MedicaoPanelItem item) {
        return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(item.HeaderValue),
              );
            },
            body: ListTile(title: Text(item.ExpandedValue)),
            isExpanded: item.IsExpanded);
      }).toList(),
    );
  }
}
