import 'dart:io';

import 'package:contato/helper/contato_helper.dart';
import 'package:flutter/material.dart';

class ContatoPage extends StatefulWidget {
  final Contato contato;

  ContatoPage({this.contato});

  @override
  _ContatoPageState createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {
  Contato _contatoEditado;
  bool textEditado = false;

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();

  final _nomeFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.contato == null) {
      _contatoEditado = Contato();
    } else {
      _contatoEditado = Contato.from(widget.contato.toMap());
      _nomeController.text = _contatoEditado.nome;
      _emailController.text = _contatoEditado.email;
      _telefoneController.text = _contatoEditado.telefone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_contatoEditado.nome ?? "Novo Contato"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_contatoEditado.nome != null && _contatoEditado.nome.isNotEmpty) {
            Navigator.pop(context, _contatoEditado);
          } else {
            FocusScope.of(context).requestFocus(_nomeFocus);
          }
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                height: 140.0,
                width: 140.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: _contatoEditado.imagem != null
                            ? FileImage(File(_contatoEditado.imagem))
                            : AssetImage("imagem/person.png"))),
              ),
            ),
            TextField(
              controller: _nomeController,
              focusNode: _nomeFocus,
              decoration: InputDecoration(labelText: "Nome"),
              onChanged: (text) {
                textEditado = true;
                setState(() {
                  _contatoEditado.nome = text;
                });
              },
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
              onChanged: (text) {
                textEditado = true;
                _contatoEditado.email = text;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _telefoneController,
              decoration: InputDecoration(labelText: "Telefone"),
              onChanged: (text) {
                textEditado = true;
                _contatoEditado.telefone = text;
              },
              keyboardType: TextInputType.phone,
            )
          ],
        ),
      ),
    );
  }
}
