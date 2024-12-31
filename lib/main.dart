import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 5,
          color: Colors.black,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _displayText = "0";
  String _currentInput = "";
  String _operator = "";
  double? _firstOperand;

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _displayText = "0";
        _currentInput = "";
        _operator = "";
        _firstOperand = null;
      } else if (value == "=") {
        if (_firstOperand != null && _operator.isNotEmpty && _currentInput.isNotEmpty) {
          double secondOperand = double.parse(_currentInput);
          double result;

          switch (_operator) {
            case "+":
              result = _firstOperand! + secondOperand;
              break;
            case "-":
              result = _firstOperand! - secondOperand;
              break;
            case "*":
              result = _firstOperand! * secondOperand;
              break;
            case "/":
              result = secondOperand != 0 ? _firstOperand! / secondOperand : double.nan;
              break;
            default:
              result = 0;
          }

          _displayText = result.toString();
          _currentInput = "";
          _operator = "";
          _firstOperand = null;
        }
      } else if ("+-*/".contains(value)) {
        if (_currentInput.isNotEmpty) {
          _firstOperand = double.parse(_currentInput);
          _operator = value;
          _currentInput = "";
        }
      } else {
        _currentInput += value;
        _displayText = _currentInput;
      }
    });
  }

  Widget _buildButton(String text, {Color? color}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(text),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            backgroundColor: color ?? Colors.deepPurple,
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.centerRight,
            child: Text(
              _displayText,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              Row(
                children: [
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("/", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("*", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("-", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton("C", color: Colors.red),
                  _buildButton("0"),
                  _buildButton("=", color: Colors.green),
                  _buildButton("+", color: Colors.orange),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}