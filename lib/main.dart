import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override //覆盖

  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Rainweat Flutter",
      home: HomePage(),
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
    );
  }
}

//主页
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bigStyle = TextStyle(
      fontSize: 34.0,
      fontWeight: FontWeight.w600,
    );

    Widget weatherText(String text) {
      return new Text(
        text,
        style: bigStyle,
      );
    }

    return new Scaffold(
      appBar: AppBar(
        title: new Text(
          "rainweat Flutter",
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.green,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            //天气展示
            new Positioned(
              top: 0.0,
              child: new Container(
                width: MediaQuery.of(context).size.width,
                height: 500.0,
                // color: Colors.red,
                child: ListView(
                  children: <Widget>[
                    weatherText("北京"),
                    weatherText("感冒:12312312312不感冒不感冒不感冒"),
                    weatherText("最高:"),
                    weatherText("最低:"),
                    weatherText("风力风向:"),
                    weatherText("类型:"),
                  ],
                ),
              ),
            ),
            //定位按钮
            new Positioned(
              top: 510.0,
              width: 64.0,
              height: 64.0,
              child: LoctionButtonWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class LoctionButtonWidget extends StatefulWidget {
  @override
  createState() {
    return LoctionButtonWidgetState();
  }
}

class LoctionButtonWidgetState extends State<LoctionButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      child: new Icon(
        Icons.location_on,
        color: Colors.green,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
      onPressed: _loctionButtonAction,
    );
  }

  void _loctionButtonAction() {
    debugPrint("loctionButtonAction");
  }
}
