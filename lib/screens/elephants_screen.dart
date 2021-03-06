import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:elephant_app/screens/elephant_info_screen.dart';
import 'package:flutter/material.dart';

import 'package:elephant_app/components/loader_component.dart';
import 'package:elephant_app/helpers/api_helper.dart';
import 'package:elephant_app/models/elephant.dart';
import 'package:elephant_app/models/response.dart';

class ElephantsScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ElephantsScreen();

  @override
  _ElephantsScreenState createState() => _ElephantsScreenState();
}

class _ElephantsScreenState extends State<ElephantsScreen> {
  // ignore: prefer_final_fields
  List<Elephant> _elephants = [];
  bool _showLoader = false;
  bool _isFiltered = false;
  String _search = '';

  @override
  void initState() {
    super.initState();
    _getElephants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[400],
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Elefantes'),
        actions: <Widget>[
          _isFiltered
              ? IconButton(
                  onPressed: _removeFilter, icon: const Icon(Icons.filter_none))
              : IconButton(
                  onPressed: _showFilter, icon: const Icon(Icons.filter_alt))
        ],
      ),
      body: Center(
        child: _showLoader
            ? const LoaderComponent(text: 'Por favor espere...')
            : _getContent(),
      ),
    );
  }

  // ignore: prefer_void_to_null
  Future<Null> _getElephants() async {
    setState(() {
      _showLoader = true;
    });

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _showLoader = false;
      });
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: 'Verifica que estes conectado a internet.',
          actions: <AlertDialogAction>[
            const AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }

    Response response = await ApiHelper.getElephants();

    setState(() {
      _showLoader = false;
    });

    if (!response.isSuccess) {
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: response.message,
          actions: <AlertDialogAction>[
            const AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }

    setState(() {
      _elephants = response.result;
    });
  }

  Widget _getContent() {
    // ignore: prefer_is_empty
    return _elephants.length == 0 ? _noContent() : _getListView();
  }

  Widget _noContent() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Text(
          _isFiltered ? 'No hay informaci??n.' : 'No hay elefantes.',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _getListView() {
    return RefreshIndicator(
      onRefresh: _getElephants,
      child: ListView(
        children: _elephants.map((e) {
          return Card(
            child: InkWell(
              onTap: () => _goInfoElephant(e),
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: CachedNetworkImage(
                        imageUrl: e.image,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                        placeholder: (context, url) => const Image(
                          image: NetworkImage(
                              'https://www.pngitem.com/pimgs/m/296-2961253_loading-red-icon-png-transparent-png.png'),
                          fit: BoxFit.cover,
                          height: 80,
                          width: 80,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  'Nombre: ${e.name}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showFilter() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text('Filtrar Elefantes'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Escriba el nombre del elefante'),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                      hintText: 'Criterio de b??squeda...',
                      labelText: 'Buscar',
                      suffixIcon: Icon(Icons.search)),
                  onChanged: (value) {
                    _search = value;
                  },
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar')),
              TextButton(
                  onPressed: () => _filter(), child: const Text('Filtrar')),
            ],
          );
        });
  }

  void _removeFilter() {
    setState(() {
      _isFiltered = false;
    });
    _getElephants();
  }

  void _filter() {
    if (_search.isEmpty) {
      return;
    }

    List<Elephant> filteredList = [];
    for (var elephant in _elephants) {
      // ignore: unnecessary_null_comparison
      if (elephant.name != null) {
        if (elephant.name.toUpperCase().contains(_search.toUpperCase())) {
          filteredList.add(elephant);
        }
      }
    }

    setState(() {
      _elephants = filteredList;
      _isFiltered = true;
    });

    Navigator.of(context).pop();
  }

  void _goInfoElephant(Elephant elephant) async {
    String? result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ElephantInfoScreen(
                  elephant: elephant,
                )));
    if (result == 'yes') {
      _getElephants();
    }
  }
}
