import 'package:flutter/material.dart';

class TelaResultado extends StatelessWidget {
  final String nome;
  final double imc;
  final String classificacao;

  TelaResultado({
    required this.nome,
    required this.imc,
    required this.classificacao,
  });

  Color _corClassificacao(String classificacao) {
    final c = classificacao.trim().toLowerCase();
    if (c == 'abaixo do peso') return Colors.blue;
    if (c == 'peso normal') return Colors.green;
    if (c == 'sobrepeso') return Colors.orange;
    if (c == 'obesidade grau i') return Colors.deepOrange;
    if (c == 'obesidade grau ii') return Colors.red;
    if (c == 'obesidade grau iii') return Colors.purple;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final cor = _corClassificacao(classificacao);

    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado do IMC'),
        backgroundColor: cor,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: cor, width: 3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$nome, seu IMC é:',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 10),
              Text(
                imc.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: cor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Classificação: $classificacao',
                style: TextStyle(fontSize: 20, color: cor),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: cor),
                child: Text('Voltar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
