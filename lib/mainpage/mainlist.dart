

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'mainlist_detail.dart';

class mainList extends StatefulWidget {
  //const mainList({Key? key}) : super(key: key);

  late String idx;

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

  TextEditingController _tanggal = TextEditingController();
  TextEditingController _tanggal2 = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Searching Data"),centerTitle: true,),
      body: Column(
        children: [
          Container(
                  padding: EdgeInsets.only(top: 15,left: 15,right: 15,bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),

                      )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 35,),


                      /*Padding(
                        padding: EdgeInsets.only(left: 3,bottom: 15),
                        child: Text("Isi tanggal Pembuatan Akta!",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,wordSpacing: 2,
                              color: Colors.white
                          ),),
                      ),*/


                      Center(
                        child: Text("Masukan Rentang Tanggal Pembuatan Akta",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 8,right: 8,left: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  readOnly: true,
                                  decoration: new InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                      prefixIcon: Icon(Icons.calendar_today,color: Colors.white,),
                                      labelText: "Awal",
                                      labelStyle: TextStyle(
                                        color: Colors.white, //<-- SEE HERE
                                      ),
                                      border: new OutlineInputBorder(
                                          borderRadius: new BorderRadius.circular(20.0),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      )
                                  ),
                                  onTap: () async {
                                    DateTime? pickeddate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100)
                                    );
                                    if (pickeddate != null){
                                      setState(() {
                                        _tanggal.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                                      });
                                    }
                                  },
                                  controller: _tanggal,
                                  validator: (value) => value!.isEmpty ? 'Masukan Tanggal' : null
                              ),
                            ),
                            SizedBox(width: 30,),

                            Expanded(
                              child: TextFormField(
                                  readOnly: true,
                                  style: TextStyle(color: Colors.white),
                                  decoration: new InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                      prefixIcon: Icon(Icons.calendar_today,color: Colors.white,),
                                      labelText: "Akhir",
                                      labelStyle: TextStyle(
                                        color: Colors.white, //<-- SEE HERE
                                      ),
                                      border: new OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(20.0),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      )
                                  ),
                                  onTap: () async {
                                    DateTime? pickeddate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100)
                                    );
                                    if (pickeddate != null){
                                      setState(() {
                                        _tanggal.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                                      });
                                    }
                                  },
                                  controller: _tanggal,
                                  validator: (value) => value!.isEmpty ? 'Masukan Tanggal' : null
                              ),
                            ),

                          ],
                        ),
                      ),



                      Container(
                        margin: EdgeInsets.only(top: 5,bottom: 20),
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Ketikan Sesuatu Disini",
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.5)
                            ),
                            prefixIcon: Icon(
                              Icons.search
                            )
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            //Icons.dashboard,
                            icon: Icon(Icons.arrow_back,size: 30,),
                            //size: 30,
                            color: Colors.white,
                            //onPressed: () => Scaffold.of(context).openDrawer(),
                            onPressed: () {},
                          ),
                          ElevatedButton(
                              onPressed: (){},
                              child: Text("Cari")),
                        ],),

                    ],
                  ),
                ),

          !isDataLoaded ? const Center(child: CircularProgressIndicator(),):Expanded(
            child: ListView.builder(
                itemCount: jsonList == null ? 0 : jsonList.length,
                itemBuilder: (BuildContext context,int index ){
                  return Card(
                    child: ListTile(
                      onTap:() {
                        print(jsonList[index]);
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MainListDetail(idx: jsonList[index],)));},
                      title: Text(jsonList[index]['atas_nama']),
                      subtitle: Text(jsonList[index]['tanggal_pembuatan']),
                    ),);
                }),
          )




        ],
      ),


      /*!isDataLoaded ? const Center(child: CircularProgressIndicator(),):ListView.builder(
          itemCount: jsonList == null ? 0 : jsonList.length,
          itemBuilder: (BuildContext context,int index ){
            return Card(
              child: ListTile(
                onTap:() {
                  print(jsonList[index]);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MainListDetail(idx: jsonList[index],)));},
                title: Text(jsonList[index]['atas_nama']),
                subtitle: Text(jsonList[index]['tanggal_pembuatan']),
              ),);
          })*/
    );
  }

  }

