import 'package:calculator/constants/colors.dart';
import 'package:calculator/screen/new_container.dart'; // Make sure the file name is correct
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  bool darkMode = true;
  String _output = "0"; // Displayed output
  String _input = ""; // Current input string
  String _previousInput = ""; // Previous input for calculations
  String _operation = ""; // Current operation
  double _result = 0.0; // Calculated result

  void _onTrigonometricPress(String? function) {
    if (_input.isEmpty) return;

    double inputValue = double.tryParse(_input) ?? 0.0;
    double result;
    //double radians = degreesToRadians(inputValue);

    switch (function) {
      case 'sin':
        result = sin(inputValue);
        break;
      case 'cos':
        result = cos(inputValue);
        break;
      case 'tan':
        result = tan(inputValue);
        break;
      case '%':
        result = inputValue / 100;
        break;
      default:
        return;
    }

    setState(() {
      _output = result.toString();
      _input = result.toString();
    });
  }
  //end of trignometry

  void _onDigitPress(String digit) {
    setState(() {
      _input += digit;
      _output = _input;
    });
  }

  void _onOperationPress(String operation) {
    setState(() {
      if (_input.isNotEmpty) {
        _previousInput = _input;
        _input = "";
        _operation = operation;
      }
    });
  }

  void _calculateResult() {
    double num1 = double.tryParse(_previousInput) ?? 0.0;
    double num2 = double.tryParse(_input) ?? 0.0;

    switch (_operation) {
      case '+':
        _result = num1 + num2;
        break;
      case '-':
        _result = num1 - num2;
        break;
      case 'x':
        _result = num1 * num2;
        break;
      case '/':
        _result = num1 / num2;
        break;
      // Add other operations as needed
    }

    setState(() {
      _output = _result.toString();
      _input = _result.toString();
      _previousInput = "";
      _operation = "";
    });
  }

  void _clear() {
    setState(() {
      _input = "";
      _previousInput = "";
      _operation = "";
      _output = "0";
      _result = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? colorDark : colorLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            darkMode ? darkMode = false : darkMode = true;
                          });
                        },
                        child: _switchMode()),
                    SizedBox(
                      height: 80,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        _output,
                        style: TextStyle(
                            fontSize: 55,
                            fontWeight: FontWeight.bold,
                            color: darkMode ? Colors.white : Colors.black),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '=',
                          style: TextStyle(
                              fontSize: 35,
                              color: darkMode ? Colors.green : Colors.grey),
                        ),
                        Text(
                          _input,
                          style: TextStyle(
                              fontSize: 20,
                              color: darkMode ? Colors.green : Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buttonOval(title: 'sin'),
                        _buttonOval(title: 'cos'),
                        _buttonOval(title: 'tan'),
                        _buttonOval(title: '%')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buttonRounded(
                            title: 'C',
                            textColor:
                                darkMode ? Colors.green : Colors.redAccent),
                        _buttonRounded(title: '('),
                        _buttonRounded(title: ')'),
                        _buttonRounded(
                            title: '/',
                            textColor:
                                darkMode ? Colors.green : Colors.redAccent),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buttonRounded(title: '7'),
                        _buttonRounded(title: '8'),
                        _buttonRounded(title: '9'),
                        _buttonRounded(
                            title: 'x',
                            textColor:
                                darkMode ? Colors.green : Colors.redAccent),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buttonRounded(title: '4'),
                        _buttonRounded(title: '5'),
                        _buttonRounded(title: '6'),
                        _buttonRounded(
                            title: '-',
                            textColor:
                                darkMode ? Colors.green : Colors.redAccent),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buttonRounded(title: '1'),
                        _buttonRounded(title: '2'),
                        _buttonRounded(title: '3'),
                        _buttonRounded(
                            title: '+',
                            textColor:
                                darkMode ? Colors.green : Colors.redAccent),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buttonRounded(title: '0'),
                        _buttonRounded(title: ','),
                        _buttonRounded(
                            icon: Icons.backspace_outlined,
                            iconColor:
                                darkMode ? Colors.green : Colors.redAccent),
                        _buttonRounded(
                            title: '=',
                            textColor:
                                darkMode ? Colors.green : Colors.redAccent),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonRounded({
    String? title,
    double padding = 16,
    IconData? icon,
    Color? iconColor,
    Color? textColor,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          if (title != null) {
            switch (title) {
              case 'C':
                _clear();
                break;
              case '=':
                _calculateResult();
                break;
              case '+':
              case '-':
              case 'x':
              case '/':
                _onOperationPress(title);
                break;
              default:
                _onDigitPress(title);
                break;
            }
          } else if (icon == Icons.backspace_outlined) {
            setState(() {
              _input = _input.isNotEmpty
                  ? _input.substring(0, _input.length - 1)
                  : "";
              _output = _input;
            });
          }
        },
        child: NewConatainer(
          darkMode: darkMode,
          borderRadius: BorderRadius.circular(40),
          padding: EdgeInsets.all(padding),
          child: Container(
            width: 40, // Set a fixed size or use a different variable
            height: 40, // Set a fixed size or use a different variable
            child: Center(
              child: title != null
                  ? Text(
                      '$title',
                      style: TextStyle(
                        color: textColor ??
                            (darkMode ? Colors.white : Colors.black),
                        fontSize: 30,
                      ),
                    )
                  : Icon(
                      icon,
                      color: iconColor,
                      size: 30,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonOval({String? title, double padding = 17}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () => _onTrigonometricPress(title),
        child: NewConatainer(
          darkMode: darkMode,
          borderRadius: BorderRadius.circular(50),
          padding:
              EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
          child: Container(
            width: padding * 2, // Adjust the width as needed
            height: padding, // Adjust the height as needed
            child: Center(
              child: Text(
                '$title',
                style: TextStyle(
                  color: darkMode ? Colors.white : Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _switchMode() {
    return NewConatainer(
      darkMode: darkMode,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.wb_sunny,
                color: darkMode ? Colors.grey : Colors.redAccent),
            Icon(Icons.nightlight_outlined,
                color: darkMode ? Colors.green : Colors.grey)
          ],
        ),
      ),
    );
  }
}
