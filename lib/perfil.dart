import 'dart:io';

import 'package:flutter/material.dart';
import 'package:validadordesenhaselisson/home.dart';
import 'package:validadordesenhaselisson/listacartoes.dart';
import 'package:image_picker/image_picker.dart';

import 'Data/Perfil/perfil_sqlite_datasource.dart';
import 'main.dart';

class cadperfilUsuario extends StatelessWidget {
  const cadperfilUsuario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Perfil do usuário',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  final _picker = ImagePicker();

  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  String _nome = '';
  String _email = '';
  String _senha = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seu perfil'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black38,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Column(children: [
            Center(
              child: ElevatedButton(
                onPressed: _openImagePicker,
                child: const Text('Escolha a imagem'),
              ),
            ),
            const SizedBox(height: 35),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 300,
              color: Colors.grey[300],
              child: _image != null
                  ? Image.file(_image!, fit: BoxFit.cover)
                  : const Text('Selecione a imagem desejada'),
            ),
            const SizedBox(height: 15),
            nome(),
            const SizedBox(height: 15),
            email(),
            const SizedBox(height: 15),
            senha(),
            const SizedBox(height: 15),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 64, 21, 158),
        foregroundColor: Color.fromARGB(255, 158, 4, 4),
        onPressed: () {
          perfilSQLiteDatasource().inserirPerfil(_nome, _email, _senha);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MyApp();
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  TextFormField email() {
    return TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor digite o email';
          }
        },
        onChanged: (value) => setState(() {
              _email = value;
            }),
        keyboardType: TextInputType.emailAddress,
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: 'email'));
  }

  TextFormField nome() {
    return TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor insira seu nome';
          }
        },
        onChanged: (value) => setState(() {
              _nome = value;
            }),
        keyboardType: TextInputType.emailAddress,
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: 'Nome'));
  }

  TextFormField senha() {
    return TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor digite sua senha';
          }
          if (value.length < 4) {
            return 'A senha deve ser maior que 4(quatro)digitos';
          }
        },
        onChanged: (value) => setState(() {
              _senha = value;
            }),
        keyboardType: TextInputType.emailAddress,
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: 'Senha'));
  }
}
