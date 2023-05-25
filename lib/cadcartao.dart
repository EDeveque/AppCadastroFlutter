import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:validadordesenhaselisson/Data/Cartao/cartao_sqlite_datasource.dart';
import 'package:validadordesenhaselisson/listacartoes.dart';

class cadcartao extends StatefulWidget {
  @override
  _cadcartaoState createState() {
    return _cadcartaoState();
  }
}

class _cadcartaoState extends State<cadcartao> {
  TextEditingController _descricaoController = TextEditingController();
  TextEditingController _numeroCartaoController = TextEditingController();
  TextEditingController _validadeController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  bool _ocultaSenha = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar cartao'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black38,
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: ListView(
          children: <Widget>[
            fieldDescricao(),
            SizedBox(
              height: 20,
            ),
            CartaoFrente(context),
            SizedBox(
              height: 20,
            ),
            CartaoAtras(context),
            SizedBox(
              height: 05,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            cartaoSQLiteDatasource().insertCard(
                _descricaoController.text,
                _numeroCartaoController.text,
                _validadeController.text,
                _cvvController.text,
                _senhaController.text);
          },
          child: Icon(Icons.save_alt),
        ),
      ),
    );
  }

  Widget fieldNumero() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: _numeroCartaoController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Numero',
        ),
      ),
    );
  }

  Widget fieldValidade() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: _validadeController,
        keyboardType: TextInputType.datetime,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Validade',
        ),
      ),
    );
  }

  Widget fieldCvv() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: _cvvController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'CVV',
        ),
      ),
    );
  }

  Widget fieldDescricao() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: TextField(
        controller: _descricaoController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Descricao',
        ),
      ),
    );
  }

  Widget fieldSenha() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _senhaController,
        obscureText: _ocultaSenha,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Senha",
          helperText: "Digite uma senha ",
          helperStyle: TextStyle(color: Color.fromARGB(255, 141, 88, 23)),
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
        ),
      ),
    );
  }

  Widget CartaoFrente(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [cartaoFront(context)],
      ),
    );
  }

  Widget cartaoFront(context) {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      height: 300,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 16, 121, 22)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [fieldNumero(), fieldValidade(), fieldSenha()],
      ),
    );
  }

  Widget CartaoAtras(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [cartaoBack(context)],
      ),
    );
  }

  Widget cartaoBack(context) {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      height: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.amber),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(height: 40, color: Colors.black),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 40,
            color: Colors.grey,
          ),
          fieldCvv(),
        ],
      ),
    );
  }
}
