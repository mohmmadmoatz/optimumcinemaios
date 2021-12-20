import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Condtions extends StatefulWidget {
  final List<String> texxt;

  const Condtions({Key key, this.texxt}) : super(key: key);
  @override
  _ConnectwithusState createState() => _ConnectwithusState();
}

class _ConnectwithusState extends State<Condtions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("عن التطبيق"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                "شروط استخدام تطبيق فلمي",
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                widget.texxt[0],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                widget.texxt[1],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                widget.texxt[2],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
