import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsView extends StatefulWidget {
  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  List _news = [];

  void _fetchNews() async {
    final response = await http.get(
      Uri.parse(
        'https://api.twitter.com/2/tweets/search/recent?query=from:TwitterDev&tweet.fields=created_at&expansions=author_id&user.fields=created_at&max_results=3&bearer_token=YOUR_BEARER_TOKEN',
      ),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _news = data['data'];
      });
    } else {
      setState(() {
        _news = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Latest News'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset('assets/wordpress_logo.png'),
            Expanded(
              child: ListView.builder(
                itemCount: _news.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_news[index]['text']),
                    trailing: IconButton(
                      icon: Icon(Icons.open_in_new),
                      onPressed: () {
                        // Implementa una forma de abrir el enlace en el navegador
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
