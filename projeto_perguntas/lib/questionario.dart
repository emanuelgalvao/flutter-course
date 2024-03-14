import 'package:flutter/material.dart';
import 'package:projeto_perguntas/questao.dart';
import 'package:projeto_perguntas/resposta.dart';

class Questionario extends StatelessWidget {

  final Map<String, Object> _pergunta;
  final Function (int) _responder;

  Questionario(this._pergunta, this._responder);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Questao(_pergunta['texto'].toString()),
        ..._pergunta.cast()['respostas'].map((resposta) => Resposta(resposta['texto'], () => _responder(int.parse(resposta['pontuacao'].toString())))).toList()
      ],
    );
  }
}