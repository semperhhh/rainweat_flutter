import 'package:flutter/material.dart';

class loctionWidget extends StatefulWidget {
  
  @override
    createState() {
      return loctionWidgetState();    
    }
}

class loctionWidgetState extends State<loctionWidget> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("loctions"),
      ),
      body: new ListView(
        children: <Widget>[
          new TextField(
            autofocus: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "请输入城市",
            ),
          ),
          new Text("1"),
          new Text("2"),
        ],
      ),
    );
  }
}
