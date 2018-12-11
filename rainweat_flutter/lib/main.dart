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

    Widget weatherSection = new Text(
      "感冒:\n最高\n最低\n风向风力\n类型",
      style: bigStyle,
    );

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
                color: Colors.red,
                child: weatherSection,
              ),
            ),
            //定位按钮
            new Positioned(
              top: 510.0,
              child: new Container(
                width: 100.0,
                height: 60.0,
                child: new RaisedButton(
                  onPressed: (){},
                  color: Colors.orange,
                  highlightColor: Colors.black,
                  child: new Text("Beijing"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
