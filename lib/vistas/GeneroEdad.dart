import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenderAgeView extends StatefulWidget {
  @override
  _GenderAgeViewState createState() => _GenderAgeViewState();
}

class _GenderAgeViewState extends State<GenderAgeView> {
  final TextEditingController _nameController = TextEditingController();
  String _genderResult = '';
  String _ageResult = '';
  int _age = 0;

  void _predictGenderAndAge() async {
    await _predictGender();
    await _predictAge();
  }

  Future<void> _predictGender() async {
    final response = await http.get(Uri.parse('https://api.genderize.io/?name=${_nameController.text}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _genderResult = data['gender'] == 'male' ? 'Gender: Male' : 'Gender: Female';
      });
    } else {
      setState(() {
        _genderResult = 'No es ningun sexo';
      });
    }
  }

  Future<void> _predictAge() async {
    final response = await http.get(Uri.parse('https://api.agify.io/?name=${_nameController.text}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _age = data['age'];
        if (_age <= 18) {
          _ageResult = 'Joven';
        } else if (_age <= 50) {
          _ageResult = 'Adulto';
        } else {
          _ageResult = 'Viejo';
        }
      });
    } else {
      setState(() {
        _ageResult = 'No tiene edad';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gender and Age Prediction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Escriba el Nombre'),
            ),
            ElevatedButton(
              onPressed: _predictGenderAndAge,
              child: Text('Resultado'),
            ),
            SizedBox(height: 20),
            Text(_genderResult, style: TextStyle(color: _genderResult == 'Gender: Male' ? Colors.blue : Colors.pink)),
            Text('Age: $_age'),
            Text(_ageResult),
            if (_ageResult == 'Joven')
              Image.asset('assets/young.png', height: 100, width: 100)
            else if (_ageResult == 'Adulto')
              Image.asset('assets/adult.png', height: 100, width: 100)
            else if (_ageResult == 'Viejo')
                Image.asset('assets/elderly.png', height: 100, width: 100),
          ],
        ),
      ),
    );
  }
}
