import 'package:flutter/material.dart';

class InsertDataPage extends StatefulWidget {
  const InsertDataPage({super.key});

  @override
  State<InsertDataPage> createState() => _InsertDataPageState();
}

class _InsertDataPageState extends State<InsertDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Data insert karo"),),
    );
  }
}
