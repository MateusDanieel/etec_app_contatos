import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tbContato = "tb_contato";
final String idContato = "id_contato";
final String nomeContato = "nome_contato";
final String emailContato = "email_contato";
final String telefoneContato = "telefone_contato";
final String imagemContato = "imagem_contato";

class ContatoHelper {
  static final ContatoHelper _instance = ContatoHelper.internal();

  factory ContatoHelper() => _instance;

  ContatoHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final dataBasePath = await getDatabasesPath();
    final path = join(dataBasePath, "contato.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) {
      db.execute(
          "CREATE TABLE $tbContato ( $idContato INTEGER PRIMARY KEY, $nomeContato TEXT, $emailContato TEXT, $telefoneContato TEXT, $imagemContato TEXT )");
    });
  }

  Future<Contato> salvarContato(Contato contato) async {
    Database dbContato = await db;
    contato.id = await dbContato.insert(tbContato, contato.toMap());
    return contato;
  }

  getContato(int id) async {
    Database dbContato = await db;
    List<Map> maps = await dbContato.query(tbContato,
        columns: [
          idContato,
          nomeContato,
          emailContato,
          telefoneContato,
          imagemContato
        ],
        where: "$idContato = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Contato.from(maps.first);
    } else {
      return null;
    }
  }

  Future<List> getContatos() async {
    Database dbContato = await db;
    List contatos = await dbContato.rawQuery("SELECT * FROM $tbContato");
    List<Contato> listaContato = List();
    for (Map m in contatos) {
      listaContato.add(Contato.from(m));
    }
    return listaContato;
  }
}

class Contato {
  int id;
  String nome;
  String email;
  String telefone;
  String imagem;

  Contato();

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
