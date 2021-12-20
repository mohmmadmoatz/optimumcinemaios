import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Connectwithus extends StatefulWidget {
  @override
  _ConnectwithusState createState() => _ConnectwithusState();
}

class _ConnectwithusState extends State<Connectwithus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("معلومات التواصل معنا"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Optimum line for internet services",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            "للاستفسار و الاتصال",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            "07711119945-07831120999",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            "العنوان:",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            "بغداد - اليرموك - مجاور مدخل الداوودي",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
