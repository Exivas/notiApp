import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre mi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/Mifoto.png'),
            SizedBox(height: 20),
            Text(
              'Sobre esta app',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Esta es una app con varias funcionalidades que depende de varias api',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
