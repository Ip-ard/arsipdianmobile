import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainList_Detail extends StatelessWidget {
  //const MainList_Detail(data, {Key? key}) : super(key: key);
  const MainList_Detail({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Page"),
        ),
      body: Center(
        child: Text("Detail Page"),
      ),
    );
  }
}
