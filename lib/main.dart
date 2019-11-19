import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _inforText = "Informe seus Dados";

  //funcao para resetar textFiel:
  void _resetFields(){
    alturaController.text = "";
    pesoController.text = "";
    setState(() {
      _inforText = "Informe seus Dados";
      _formKey = GlobalKey<FormState>();   // Reset code Erro!
    });

  }

  void _calculate(){

    setState(() {
      double peso =  double.parse(pesoController.text);
      double altura = double.parse(alturaController.text)/100;
      double imc = peso / (altura * altura);
      print(imc);
      if(imc < 18.6){
        _inforText = "Abaixo do Peso(${imc.toStringAsPrecision(3)})";
      }else if(imc >= 18.6 && imc < 24.9){
        _inforText = "Peso Ideal(${imc.toStringAsPrecision(3)})";
      }else if(imc >= 24.9 && imc < 29.9){
        _inforText = "Levemente acima do Peso(${imc.toStringAsPrecision(3)})";
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculo de IMC"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,

      body: SingleChildScrollView(padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),

        child: Form(
          key: _formKey,

          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[

              Icon(Icons.account_circle, size: 120.0, color: Colors.lightGreen),

              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Peso(Kg)", labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 15.0),
                controller: pesoController,
                // ignore: missing_return
                validator: (value){
                  if(value.isEmpty){
                    return "Insira seu Peso";
                  }
                },

              ),

              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Altura(cm)", labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 15.0),
                controller: alturaController,
                // ignore: missing_return
                validator: (value){
                  if(value.isEmpty){
                    return "Insira sua Altura";
                  }
                },
              ),

              Padding(
                padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                child: Container(
                    height: 50.0,

                    child: RaisedButton(
                      onPressed: (){

                        if(_formKey.currentState.validate()){
                          _calculate();
                        }
                      },
                      child: Text("Calcular", style: TextStyle(color:Colors.white,fontSize: 20.0)),
                      color: Colors.green,
                    )
                ),
              ),

              Text(_inforText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 20.0)
              )
            ],
          ),
        ),
      )
    );
  }
}
