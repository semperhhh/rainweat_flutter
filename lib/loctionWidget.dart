import 'package:flutter/material.dart';
import 'city.dart';

class loctionWidget extends StatefulWidget {
  @override
  createState() {
    return loctionWidgetState();
  }
}

class loctionWidgetState extends State<loctionWidget> {
  TextEditingController _unameController = new TextEditingController(); //文本框

  void initState() {
    super.initState();
    _unameController.addListener(() {
      print(_unameController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("loctions"),
      ),
      body: new ListView.builder(
        itemCount: cityList.length,
        itemBuilder: (BuildContext context, int index) {

          // if (index == 0) {
          //   return new TextField(
          //     autofocus: true,
          //     controller: _unameController, //设置controller
          //     decoration: InputDecoration(
          //       prefixIcon: Icon(Icons.search),
          //       hintText: "请输入城市",
          //     ),
          //   );
          // }

          return cityViewCellWidget(index);
        },
      ),
    );
  }
}

class cityViewCellWidget extends StatefulWidget {
  int index;
  cityViewCellWidget(this.index);
  @override
  State<StatefulWidget> createState() {
    return cityViewCellWidgetState(index);
  }
}

class cityViewCellWidgetState extends State<cityViewCellWidget> {
  int index;
  cityViewCellWidgetState(this.index);
  TextStyle _bigStyle() {
    return TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.w300,
    );
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        print("cityList[index] -- ${cityList[index]}");
        Navigator.pop(context,cityList[index]);
      },
      child: new Container(
        alignment: Alignment.centerLeft,
        height: 64.0,
        child: new Text(
          cityList[index],
          style: _bigStyle(),
        ),
      ),
    );
  }
}
