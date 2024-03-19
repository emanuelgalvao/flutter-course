import 'package:flutter/material.dart';
import 'package:projeto_perguntas/questionario.dart';
import 'package:projeto_perguntas/resultado.dart';

main() => runApp(PerguntaApp());

class _PerguntaAppState extends State<PerguntaApp> {

  var _perguntaSelecionada = 0;
  var _pontuacaoTotal = 0;
  final List<Map<String, Object>> _perguntas = const [
        {
          'texto': 'Qual é a sua cor favorita?',
          'respostas': [
            { 'texto': 'Preto', 'pontuacao': 10},
            { 'texto': 'Vermelho', 'pontuacao': 5},
            { 'texto': 'Azul', 'pontuacao': 3},
            { 'texto': 'Amarelo', 'pontuacao': 2}
          ]
        },
        {
          'texto': 'Qual é o seu animal favorito?',
          'respostas': [
            { 'texto': 'Cobra', 'pontuacao': 10},
            { 'texto': 'Coelho', 'pontuacao': 5},
            { 'texto': 'Cachorro', 'pontuacao': 3},
            { 'texto': 'Gato', 'pontuacao': 2}
          ]
          
        },
        {
          'texto': 'Qual é o seu instrutor favorito?',
          'respostas': [
            { 'texto': 'Maria', 'pontuacao': 10},
            { 'texto': 'João', 'pontuacao': 5},
            { 'texto': 'Leo', 'pontuacao': 3},
            { 'texto': 'Pedro', 'pontuacao': 2}
          ]
        }
      ];

  void _responder(int pontuacao) {
    if (temPerguntaSelecionada) {
      setState(() {
        _perguntaSelecionada++;
        _pontuacaoTotal += pontuacao;
      });
    }
  }

  void _reiniciar() {
    setState(() {
        _perguntaSelecionada = 0;
        _pontuacaoTotal = 0;
      });
  }

  bool get temPerguntaSelecionada {
    return _perguntaSelecionada < _perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Perguntas'),
        ),
        body: temPerguntaSelecionada 
          ? Questionario(_perguntas[_perguntaSelecionada], _responder) 
          : Resultado(_pontuacaoTotal, _reiniciar),
      ),
    );
  }
}

class PerguntaApp extends StatefulWidget {

  @override
  _PerguntaAppState createState() {
    return _PerguntaAppState();
  }
}