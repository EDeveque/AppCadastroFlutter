import 'package:flutter/material.dart';
import 'package:validadordesenhaselisson/listaSenhas.dart';

import 'Data/Senha/senha_sqlite_datasource.dart';

class cadsenhas extends StatefulWidget {
  @override
  _cadsenhasState createState() {
    return _cadsenhasState();
  }
}

class _cadsenhasState extends State<cadsenhas> {
  TextEditingController _descricaoController = TextEditingController();
  TextEditingController _loginController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  bool _ocultaSenha = false;

  @override
  void initState() {
    super.initState();
    _ocultaSenha = true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar senhas'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black38,
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: Stack(
          children: <Widget>[
            ListView(children: <Widget>[
              fieldDescricao(),
              fieldLogin(),
              fieldSenha(),
            ])
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          foregroundColor: Colors.black,
          onPressed: () {
            senhaSQLiteDatasource().inserirSenha(_descricaoController.text,
                _loginController.text, _senhaController);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return listaSenhas();
            }));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget fieldDescricao() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: _descricaoController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Descricao:',
        ),
      ),
    );
  }

  Widget fieldLogin() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: _loginController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Login',
        ),
      ),
    );
  }

  Widget fieldSenha() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: TextField(
        controller: _senhaController,
        obscureText: _ocultaSenha,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: "Qual sua senha?",
          labelText: "Senha",
          helperText: "Criar senha secundaria",
          helperStyle: TextStyle(color: Color.fromARGB(255, 153, 177, 18)),
          suffixIcon: IconButton(
            icon: Icon(_ocultaSenha ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(
                () {
                  _ocultaSenha = !_ocultaSenha;
                },
              );
            },
          ),
          alignLabelWithHint: false,
          filled: true,
        ),
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
