import 'package:flutter/material.dart';

class AnalisadorCombustivel extends StatefulWidget {
  @override
  _AnalisadorCombustivelState createState() => _AnalisadorCombustivelState();
}

class _AnalisadorCombustivelState extends State<AnalisadorCombustivel> {
  TextEditingController _inputAlcool = TextEditingController();
  TextEditingController _inputGasolina = TextEditingController();
  String _resultado = '';
  void _calcular(BuildContext context) {
    String precoAlcoolStr = _inputAlcool.text;
    String precoGasolinaStr = _inputGasolina.text;
    if (precoAlcoolStr != null && precoGasolinaStr != null) {
      precoAlcoolStr = precoAlcoolStr.replaceAll(',', '.');
      precoGasolinaStr = precoGasolinaStr.replaceAll(',', '.');
      double valorPrecoAlcool = double.tryParse(precoAlcoolStr);
      double valorPrecoGasolina = double.tryParse(precoGasolinaStr);

      setState(() {
        if ((valorPrecoGasolina * 0.7) < valorPrecoAlcool) {
          _resultado = 'Não vale a pena por Álcool';
        } else {
          _resultado = 'Vale a pena por Álcool';
        }
      });

      //dismiss the keyboard
      FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Álcool ou Gasolina'),
        ),
        body: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/logo.png'),
                Text(
                  'Saiba qual a melhor opção para abastecimento do seu carro',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: _inputAlcool,
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(labelText: 'Preço Álcool, Ex: 3.50'),
                  style: TextStyle(fontSize: 24),
                ),
                TextField(
                  controller: _inputGasolina,
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(labelText: 'Preço Gasolina, Ex: 4.50'),
                  style: TextStyle(fontSize: 24),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.green,
                    child: Text('Calcular', style: TextStyle(fontSize: 24)),
                    padding: EdgeInsets.all(16),
                    onPressed: () => _calcular(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Text('Resultado: ${_resultado}', style: TextStyle(fontSize: 24)),
                )
              ],
            ),
          ),
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
