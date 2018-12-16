import 'package:flutter/material.dart';
import 'loctionWidget.dart'; //位置界面
import 'package:dio/dio.dart'; //网络请求
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'; //偏好存储

//实例化网络类
Dio dio = new Dio();
String locationString = ""; //位置
String ganMaoString; //感冒
Color backColor = Colors.white;
int currentInt = 0; //温度

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override //覆盖

  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Rainweat Flutter",
      home: HomePage(),
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

//主页
class HomePageState extends State<HomePage> with WidgetsBindingObserver {
  testLog() {
    print("testLog");
    setState(() {});
  }

  //网络请求
  getRequest() async {
    Response response;
    if (locationString == "" || locationString == null) {
      //如果为空
      return;
    }
    String url = "http://wthrcdn.etouch.cn/weather_mini?city=$locationString";
    response = await dio.get(url);
    String jsonStr = response.data.toString();

    Map JsonMap = json.decode(jsonStr);

    setState(() {
      ganMaoString = JsonMap["data"]["ganmao"];
      currentInt = int.parse(JsonMap["data"]["wendu"]);
      if (currentInt > 30) {
        backColor = Colors.red[900];
      } else if (currentInt < 30 && currentInt >= 20) {
        backColor = Colors.red;
      } else if (currentInt < 20 && currentInt >= 10) {
        backColor = Colors.yellow;
      } else if (currentInt < 10 && currentInt >= 0) {
        backColor = Colors.green;
      } else if (currentInt < 0 && currentInt >= -10) {
        backColor = Colors.blue;
      } else if (currentInt < -10) {
        backColor = Colors.orange;
      }
    });
  }

  final bigStyle = TextStyle(
    fontSize: 34.0,
    fontWeight: FontWeight.w600,
  );

  //文字
  weatherText(String string) {
    return new Text(
      string,
      style: bigStyle,
    );
  }

  //重写
  @override
  void initState() {
    super.initState();

    fileOperation()._query("LOCATION").then((onValue) {
      //then等价于await
      if (onValue == "" || onValue == null) {
        return;
      }
      locationString = onValue;
      requestOperation().getRequest().then((onValue) {
        setState(() {
          if (currentInt > 30) {
            backColor = Colors.red[900];
          } else if (currentInt < 30 && currentInt >= 20) {
            backColor = Colors.red;
          } else if (currentInt < 20 && currentInt >= 10) {
            backColor = Colors.yellow;
          } else if (currentInt < 10 && currentInt >= 0) {
            backColor = Colors.green;
          } else if (currentInt < 0 && currentInt >= -10) {
            backColor = Colors.blue;
          } else if (currentInt < -10) {
            backColor = Colors.orange;
          }
        });
      });
    });
  }

  void _loctionButtonAction() {
    debugPrint("loctionButtonAction");
    pushLoction();
  }

  //跳转位置界面
  void pushLoction() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new loctionWidget();
    })).then((onValue) {
      print("点击位置返回 -- $onValue");
      if (onValue == null || onValue == "") {
        return;
      }
      locationString = onValue;
      fileOperation()._add("LOCATION", locationString);
      requestOperation().getRequest().then((onValue) {
        print("requestOperation1 ------- $locationString");
        setState(() {
          if (currentInt > 30) {
            backColor = Colors.red[900];
          } else if (currentInt < 30 && currentInt >= 20) {
            backColor = Colors.red;
          } else if (currentInt < 20 && currentInt >= 10) {
            backColor = Colors.yellow;
          } else if (currentInt < 10 && currentInt >= 0) {
            backColor = Colors.green;
          } else if (currentInt < 0 && currentInt >= -10) {
            backColor = Colors.blue;
          } else if (currentInt < -10) {
            backColor = Colors.orange;
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: backColor,
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
                    //位置
                    new Container(
                      padding: EdgeInsets.all(15.0),
                      child: weatherText("$locationString"),
                    ),
                    //感冒
                    new Container(
                      padding: EdgeInsets.all(25.0),
                      child: new Text(
                        "$ganMaoString",
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    //温度
                    new Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 40),
                      child: new Text(
                        "$currentInt °C",
                        style: TextStyle(
                          fontSize: 48.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //定位按钮
            new Positioned(
              bottom: 44.0,
              width: 64.0,
              height: 64.0,
              child: new RaisedButton(
                child: new Icon(
                  Icons.location_on,
                  color: Colors.green,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                onPressed: _loctionButtonAction,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class fileOperation {
  //增
  _add(var key, var value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  //查
  Future<String> _query(var key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.get(key);
    print("query value --- $value");
    return value;
  }
}

//网络请求
class requestOperation {
  //网络请求
  Future getRequest() async {
    Response response;
    if (locationString == "" || locationString == null) {
      //如果为空
      return;
    }

    String url = "http://wthrcdn.etouch.cn/weather_mini?city=$locationString";
    response = await dio.get(url);
    String jsonStr = response.data.toString();
    Map JsonMap = json.decode(jsonStr);
    ganMaoString = JsonMap["data"]["ganmao"];
    currentInt = int.parse(JsonMap["data"]["wendu"]);
  }
}
