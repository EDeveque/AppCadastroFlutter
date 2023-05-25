import 'package:validadordesenhaselisson/Data/Perfil/perfil_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:validadordesenhaselisson/Data/conexao.dart';
import '../data_container.dart';

class perfilSQLiteDatasource {
  Future inserirPerfil(nome, email, senha) async {
    try {
      final Database db = await Conexao.getConexaoDB();
      await db.rawInsert('''insert into $PERFIL_TABLE_NAME(
              $PERFIL_COLUMN_NOME,
              $PERFIL_COLUMN_EMAIL,
              $PERFIL_COLUMN_SENHA)
              values(
                '${nome}','${email}','${senha}') 
              ''');
      queryAllRows();
    } catch (ex) {
      return;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await Conexao.getConexaoDB();
    return await db.query(PERFIL_TABLE_NAME);
  }

  Future<List<PerfilEntity>> getAllPerfil() async {
    Database db = await Conexao.getConexaoDB();
    List<Map> dbResult = await db.rawQuery('SELECT * from $PERFIL_TABLE_NAME');

    List<PerfilEntity> perfis = [];
    for (var row in dbResult) {
      PerfilEntity perfil = PerfilEntity();
      perfil.perfilID = row['perfilID'];
      perfil.nome = row['nome'];
      perfil.email = row['email'];

      perfis.add(perfil);
    }
    return perfis;
  }

  Future<bool> getPerfilLogin(login, senha) async {
    Database db = await Conexao.getConexaoDB();
    List<Map> dbResult = await db.rawQuery(
        'SELECT * from $PERFIL_TABLE_NAME where $PERFIL_COLUMN_EMAIL = ? and $PERFIL_COLUMN_SENHA = ?',
        [login, senha]);

    if (dbResult.isEmpty)
      return false;
    else
      return true;
  }

  Future<void> atualizarPerfil(PerfilEntity perfil) async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate(
          'update $PERFIL_TABLE_NAME set $PERFIL_COLUMN_NOME = ?, $PERFIL_COLUMN_EMAIL = ?, $PERFIL_COLUMN_SENHA = ? where id = ?',
          [perfil.nome, perfil.email, perfil.senha]);
    });
  }

  Future<void> deletarPerfil(perfilID) async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn
          .rawUpdate('delete from $PERFIL_TABLE_NAME where id = ?', [perfilID]);
    });
  }

  Future<List<PerfilEntity>> pesquisarPerfil(String filtro) async {
    List<PerfilEntity> perfis = [];
    Database db = await Conexao.getConexaoDB();
    List<Map> dbResult = await db.rawQuery(
        'SELECT * from $PERFIL_TABLE_NAME where $PERFIL_COLUMN_NOME like ?',
        ['%$filtro%']);
    for (var row in dbResult) {
      PerfilEntity perfil = PerfilEntity();
      perfil.perfilID = row['perfilID'];
      perfil.nome = row['nome'];
      perfil.email = row['email'];
      perfis.add(perfil);
    }
    return perfis;
  }

  Future<String> getPerfilLogado(email) async {
    Database db = await Conexao.getConexaoDB();
    String nome = "";
    List<Map> dbResult = await db.rawQuery(
        'SELECT * from $PERFIL_TABLE_NAME where $PERFIL_COLUMN_EMAIL = $email ');

    for (var row in dbResult) {
      nome = row['nome'];
    }
    return nome;
  }
}
