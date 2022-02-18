// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  const Calculadora({Key? key}) : super(key: key);

  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  dynamic displaytxt = 20;
  Widget btncal(String btntext, Color btncolor, Color txtcolor) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          calculation(btntext);
        },
        child: Text(
          '$btntext',
          style: TextStyle(
            fontSize: 20,
            color: txtcolor,
          ),
        ),
        shape: CircleBorder(),
        color: btncolor,
        padding: EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculadora'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Display Calculadora
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    '$text',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                btncal('AC', Colors.orange, Colors.black),
                btncal('+/-', Colors.orange, Colors.black),
                btncal('%', Colors.orange, Colors.black),
                btncal('/', Colors.orange, Colors.black),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                btncal('7', Colors.lightGreen, Colors.black),
                btncal('8', Colors.lightGreen, Colors.black),
                btncal('9', Colors.lightGreen, Colors.black),
                btncal('x', Colors.orange, Colors.black),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                btncal('4', Colors.lightGreen, Colors.black),
                btncal('5', Colors.lightGreen, Colors.black),
                btncal('6', Colors.lightGreen, Colors.black),
                btncal('+', Colors.orange, Colors.black),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                btncal('3', Colors.lightGreen, Colors.black),
                btncal('2', Colors.lightGreen, Colors.black),
                btncal('1', Colors.lightGreen, Colors.black),
                btncal('-', Colors.orange, Colors.black),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                btncal('0', Colors.lightGreen, Colors.black),
                btncal('<-', Colors.orange, Colors.black),
                btncal('.', Colors.orange, Colors.black),
                btncal('=', Colors.orange, Colors.black),
              ],
            ),
          ],
        ),
      ),
    );
  }

  dynamic text = '0';
  double numuno = 0;
  double numdos = 0;

  dynamic result = '';
  dynamic resultfinal = '';
  dynamic opr = '';
  dynamic preOpr = '';

  void calculation(btnText) {
    if (btnText == 'AC') {
      text = '0';
      numuno = 0;
      numdos = 0;
      result = '';
      resultfinal = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        resultfinal = add();
      } else if (preOpr == '-') {
        resultfinal = sub();
      } else if (preOpr == 'x') {
        resultfinal = mul();
      } else if (preOpr == '/') {
        resultfinal = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numuno == 0) {
        numuno = double.parse(result);
      } else {
        numdos = double.parse(result);
      }

      if (opr == '+') {
        resultfinal = add();
      } else if (opr == '-') {
        resultfinal = sub();
      } else if (opr == 'x') {
        resultfinal = mul();
      } else if (opr == '/') {
        resultfinal = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numuno / 100;
      resultfinal = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      resultfinal = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      resultfinal = result;
    } else {
      result = result + btnText;
      resultfinal = result;
    }

    setState(() {
      text = resultfinal;
    });
  }

  String add() {
    result = (numuno + numdos).toString();
    numuno = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numuno - numdos).toString();
    numuno = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numuno * numdos).toString();
    numuno = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numuno / numdos).toString();
    numuno = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
