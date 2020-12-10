import 'dart:io';

import 'package:contato/helper/contato_helper.dart';
import 'package:contato/ui/contato_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContatoHelper helper = ContatoHelper();

  List<Contato> contatos = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListaContato();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContatoPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: contatos.length,
          itemBuilder: (context, index) {
            return _cartaoContato(context, index);
          }),
    );
  }

  Widget _cartaoContato(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                height: 80.0,
                width: 80.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: contatos[index].imagem != null
                            ? FileImage(File(contatos[index].imagem))
                            : AssetImage("imagem/person.png"))),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(contatos[index].nome ?? "",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    Text(contatos[index].email ?? "",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    Text(contatos[index].telefone ?? "",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _showContatoPage(contato: contatos[index]);
      },
    );
  }

  void _showContatoPage({Contato contato}) async {
    final contatoEditado = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContatoPage(
                  contato: contato,
                )));
    if (contatoEditado != null) {
      if (contato != null) {
        await helper.updateContato(contatoEditado);
      } else {
        helper.salvarContato(contatoEditado);
      }
    }
  }

  void getListaContato() {
    helper.getContatos().then((list) {
      setState(() {
        print(list);
        contatos = list;
      });
    });
  }
}
