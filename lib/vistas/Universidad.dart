import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class UniversitiesView extends StatefulWidget {
  @override
  _UniversitiesViewState createState() => _UniversitiesViewState();
}

class _UniversitiesViewState extends State<UniversitiesView> {
  final TextEditingController _controller = TextEditingController();
  List _universities = [];

  void _fetchUniversities() async {
    final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=${_controller.text}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _universities = data;
      });
    } else {
      setState(() {
        _universities = [];
      });
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universidad de paises'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Coloca el nombre del pais en ingles'),
            ),
            ElevatedButton(
              onPressed: _fetchUniversities,
              child: Text('Rsultado'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _universities.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_universities[index]['name']),
                    subtitle: Text(_universities[index]['domains'][0]),
                    trailing: IconButton(
                      icon: Icon(Icons.open_in_new),
                      onPressed: () {
                        _launchURL(_universities[index]['web_pages'][0]);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
