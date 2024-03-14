import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {

  final int _pontuacaoFinal;
  final Function () _reiniciar;

  Resultado(this._pontuacaoFinal, this._reiniciar);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Parabéns!',
            style: TextStyle(fontSize: 28),
          ),
          Text('Você marcou ${_pontuacaoFinal.toString()} pontos!'),
          ElevatedButton(
            onPressed: _reiniciar, 
            child: Text('Reiniciar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white
            )
          )
        ],
      )
    );
  }
}