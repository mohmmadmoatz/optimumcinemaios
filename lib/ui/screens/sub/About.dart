import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  final String texxt;

  const About({Key key, this.texxt}) : super(key: key);
  @override
  _ConnectwithusState createState() => _ConnectwithusState();
}

class _ConnectwithusState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("عن التطبيق"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                widget.texxt,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
