// ignore_for_file: use_key_in_widget_constructors, unnecessary_string_interpolations

import 'package:cached_network_image/cached_network_image.dart';
import 'package:elephant_app/components/loader_component.dart';
import 'package:elephant_app/models/elephant.dart';
import 'package:flutter/material.dart';

class ElephantInfoScreen extends StatefulWidget {
  final Elephant elephant;
  const ElephantInfoScreen({required this.elephant});

  @override
  _ElephantInfoScreenState createState() => _ElephantInfoScreenState();
}

class _ElephantInfoScreenState extends State<ElephantInfoScreen> {
  // ignore: prefer_final_fields
  bool _showLoader = false;
  late Elephant _elephant;

  @override
  void initState() {
    super.initState();
    _elephant = widget.elephant;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('${_elephant.name.toUpperCase()}'),
      ),
      body: Center(
        child: _showLoader
            ? const LoaderComponent(
                text: 'Por favor espere...',
              )
            : _getContent(),
      ),
    );
  }

  Widget _getContent() {
    return Column(
      children: <Widget>[
        _showInfoElephant(),
      ],
    );
  }

  Widget _showInfoElephant() {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: CachedNetworkImage(
                  imageUrl: _elephant.image,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                  height: 150,
                  width: 150,
                  placeholder: (context, url) => const Image(
                    image: NetworkImage(
                        'https://www.kananss.com/wp-content/uploads/2021/06/51-519068_loader-loading-progress-wait-icon-loading-icon-png-1.png'),
                    fit: BoxFit.cover,
                    height: 150,
                    width: 150,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            const Text('Nombre: ',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)),
                            Text(
                              _elephant.name,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            const Text('Afiliación: ',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)),
                            Text(
                              _elephant.affiliation,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            const Text('Especie: ',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)),
                            Text(
                              _elephant.species,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            const Text('Sexo: ',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)),
                            Text(
                              _elephant.sex,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            const Text('ficticio:',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)),
                            Text(
                              _elephant.fictional,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            const Text('dob: ',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)),
                            Text(
                              _elephant.dob,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            const Text('dod: ',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)),
                            Text(
                              _elephant.dod,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            const Center(
                              child: Text('Nota: ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                            ),
                            Center(
                              child: Text(
                                ("${_elephant.note}"),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
