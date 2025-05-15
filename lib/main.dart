import 'package:flutter/material.dart';
import 'imc.dart';
import 'tela_resultado.dart';

void main() {
  runApp(AppIMC());
}

class AppIMC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      home: Tela1(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Tela1 extends StatelessWidget {
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                'assets/logo.png',
                height: 120,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _pesoController,
                decoration: InputDecoration(labelText: 'Peso (kg)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) => value!.isEmpty ? 'Informe o peso' : null,
              ),
              TextFormField(
                controller: _alturaController,
                decoration: InputDecoration(labelText: 'Altura (m)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) => value!.isEmpty ? 'Informe a altura' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final peso = double.parse(_pesoController.text.replaceAll(',', '.'));
                    final altura = double.parse(_alturaController.text.replaceAll(',', '.'));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaResultado(peso: peso, altura: altura),
                      ),
                    );
                  }
                },
                child: Text('Calcular IMC'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TelaResultado extends StatelessWidget {
  final double peso;
  final double altura;

  TelaResultado({required this.peso, required this.altura});

  // Método para definir a cor de acordo com a classificação
  Color _corClassificacao(String classificacao) {
    switch (classificacao) {
      case 'Abaixo do peso':
        return Colors.blue;
      case 'Peso normal':
        return Colors.green;
      case 'Sobrepeso':
        return Colors.orange;
      case 'Obesidade grau I':
        return Colors.deepOrange;
      case 'Obesidade grau II':
        return Colors.red;
      case 'Obesidade grau III':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final calculadora = CalculadoraIMC(peso: peso, altura: altura);
    final imc = calculadora.calcularIMC();
    final classificacao = calculadora.classificarIMC();
    final cor = _corClassificacao(classificacao);

    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado'),
        backgroundColor: cor,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: cor, width: 4),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Seu IMC é ${imc.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: cor),
              ),
              SizedBox(height: 10),
              Text(
                "Classificação: $classificacao",
                style: TextStyle(fontSize: 20, color: cor),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () => Navigator.pop(context),
                child: Text("Voltar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
