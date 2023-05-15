

import 'dart:io';

import 'package:arsipdian/mainpage/post_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'mainlist_detail.dart';

class mainList extends StatefulWidget {
  const mainList({Key? key}) : super(key: key);

  @override
  State<mainList> createState() => _mainListState();
}

class _mainListState extends State<mainList> {

  late List jsonList;
  bool isDataLoaded = false;

  @override
  void initState(){
    getData();
  }

  //DIOOOO
  void getData() async {
    try {
      var response = await Dio()
          .get('http://10.0.2.2/arsipdian/public/api/posts');

      if(response.statusCode == 200){
        setState(() {
          jsonList = response.data['data'] as List;
          print(jsonList.length);
          isDataLoaded = true;
        });
      }else{
        print(response.statusCode);
      }

      //print(response);
    } catch (e) {
      print(e);
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Searching Data"),centerTitle: true,),
      body: /*!isDataLoaded ? const Center(child: CircularProgressIndicator(),):
          errorMsg.isNotEmpty ? Center(child: Text(errorMsg)) : postList.data.isEmpty ? const Center(child: Text('No Data')) :
              ListView.builder(
                  itemCount: postList.data.length,
                  itemBuilder: (context, index) => getMyRow(index))*/


      !isDataLoaded ? const Center(child: CircularProgressIndicator(),):ListView.builder(
          itemCount: jsonList == null ? 0 : jsonList.length,
          itemBuilder: (BuildContext context,int index ){
            return Card(
              child: ListTile(
                onTap:() {
                  print(jsonList[index]);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MainList_Detail()));},
                title: Text(jsonList[index]['atas_nama']),
                subtitle: Text(jsonList[index]['tanggal_pembuatan']),
              ),);
          })
    );
  }

  }

