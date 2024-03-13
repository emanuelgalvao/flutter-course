import 'package:flutter/material.dart';

class Resposta extends StatelessWidget {

  final String texto;
  final void Function() onPressed;

  const Resposta(this.texto, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ElevatedButton(
        onPressed: onPressed, 
        child: Text(texto),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white
          )
        ),
      );
  }
}