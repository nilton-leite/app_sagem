import 'package:flutter/material.dart';

class Revision extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Revisão',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              print('Salvando...');
            },
            child: Text(
              'Salvar',
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
      body: Center(
        child: Text("Full-screen dialog"),
      ),
    );
  }
}
