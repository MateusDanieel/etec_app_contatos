import 'package:flutter/material.dart';

final String tbContato = "tb_contato";
final String idContato = "id_contato";
final String nomeContato = "nome_contato";
final String emailContato = "email_contato";
final String telefoneContato = "telefone_contato";
final String imagemContato = "imagem_contato";

class ContatoHelper {}

class Contato {
  int id;
  String nome;
  String email;
  String telefone;
  String imagem;

  Contato.from(Map map) {
    id = map[idContato];
    nome = map[nomeContato];
    email = map[emailContato];
    telefone = map[telefoneContato];
    imagem = map[imagemContato];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nomeContato: nome,
      emailContato: email,
      telefoneContato: telefone,
      imagemContato: imagem
    };
    if (id != null) {
      map[idContato] = id;
    }

    return map;
  }

  @override
  String toString() {
    return "Contato( id: $id nome: $nome e-mail: $email imagem: $imagem";
  }
}
