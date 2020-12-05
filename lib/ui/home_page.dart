import 'package:contato/helper/contato_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  ContatoHelper helper = ContatoHelper();

  @override
  void initState() {
    super.initState();
    Contato contato = Contato();
    contato.nome = "Chico";
    contato.email = "chico@gmail.com";
    contato.telefone = "11111111";
    contato.imagem = "teste";
    helper.salvarContato(contato);
    helper.getContatos().then((list) {
      print(list);
    });

    print(helper.getContatos());
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
