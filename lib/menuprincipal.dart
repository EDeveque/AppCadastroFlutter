import 'package:flutter/material.dart';
import 'Data/Perfil/perfil_sqlite_datasource.dart';
import 'geradorsenhas.dart';
import 'perfil.dart';

class menuprincipal extends StatefulWidget {
  final String email;
  const menuprincipal({Key? key, required this.email}) : super(key: key);

  @override
  _menuprincipalState createState() {
    return _menuprincipalState();
  }
}

class _menuprincipalState extends State<menuprincipal> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          drawer: Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text('Usuario'),
                  accountEmail: Text(widget.email),
                  currentAccountPicture: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                        'https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584_960_720.png'),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                ListTile(
                    leading: Icon(Icons.star),
                    title: Text("Favoritos"),
                    subtitle: Text("Favoritados"),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      debugPrint('TOUCH');
                    }),
                ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text("Perfil"),
                    subtitle: Text("Perfil utilizador"),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return cadperfilUsuario();
                      }));
                    }),
                ListTile(
                    leading: Icon(Icons.password_sharp),
                    title: Text("Gerador de senhas"),
                    subtitle: Text("Gere suas senhas"),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return geradorSenha();
                      }));
                    }),
              ],
            ),
          ),
          appBar: AppBar(
              backgroundColor: Colors.teal,
              title: const Text('Menu Principal')),
          body: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Deslize para cadastro e listagem",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.arrow_back),
                          Text(
                            "Senhas",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Cartoes",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.arrow_forward),
                        ],
                      )
                    ],
                  ),
                ],
              ))),
    );
  }

  Future<String> getNome(email) async {
    return Future.value(perfilSQLiteDatasource().getPerfilLogado(email));
  }
}
