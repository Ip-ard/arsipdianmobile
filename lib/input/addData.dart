import 'dart:io';


import 'package:arsipdian/services/dio.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';


import '../services/auth.dart';

class addData extends StatefulWidget {
  const addData({Key? key}) : super(key: key);

  @override
  State<addData> createState() => _addDataState();
}

class _addDataState extends State<addData> {

  final storage = new FlutterSecureStorage();

  ////////////////////////////////////////
  final _formKey2 = GlobalKey<FormState>();
  TextEditingController _atas_nama = TextEditingController();
  TextEditingController _keterangan = TextEditingController();
  TextEditingController _tanggal = TextEditingController();

  ///////////////////////////////////////

  @override
  void initState() {
    super.initState();
    readToken();
  }

  void readToken() async {
    String? token = await storage.read(key: 'token');
    Provider.of<Auth>(context, listen: false).tryToken(token: token!);
    print(token);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambahkan Data"),backgroundColor: Colors.transparent,elevation: 0,),
      backgroundColor: Color(0xFFffffff),

      body: Center(
        child: ListView(
          children: <Widget> [Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Form(
              key: _formKey2,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0,right: 8.0,left: 8.0,bottom: 8.0),
                child: Column(

                  children: [

                    SizedBox(height: MediaQuery. of(context).size.height*0.04,),
                  Text("Masukan Data",style: TextStyle(fontSize: 30,color: Colors.black,),),
                    SizedBox(height: MediaQuery. of(context).size.height*0.04,),


                  TextFormField(
                    decoration: new InputDecoration(
                        hintText: "Masukan Atas Nama",
                      labelText: "Atas Nama",
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0)
                      )
                    ),
                      controller: _atas_nama,
                      validator: (value) => value!.isEmpty ? 'Masukan Atas Nama ' : null,
                  ),

                  new Padding(padding: new EdgeInsets.only(top:20.0)),

                    TextFormField(
                        decoration: new InputDecoration(
                            hintText: "Masukan Tanggal",
                            labelText: "Tanggal",
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(20.0)
                            )
                        ),
                        controller: _tanggal,
                        validator: (value) => value!.isEmpty ? 'Masukan Tanggal' : null
                    ),

                    new Padding(padding: new EdgeInsets.only(top:20.0)),

                  TextFormField(
                      decoration: new InputDecoration(
                          hintText: "Masukan Keterangan",
                          labelText: "Keterangan",
                          border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(20.0)
                          )
                      ),
                      controller: _keterangan,
                      validator: (value) => value!.isEmpty ? 'Masukan Keterangan' : null
                  ),

                    ElevatedButton(
                        onPressed: (){
                          uploadPDF();
                        },
                        child: Text("Upload File")),
                    ElevatedButton(
                      onPressed: (){

                        Map createData = {
                          'atas_nama' : _atas_nama.text,
                          'keterangan' : _keterangan.text,
                          'tanggal_pembuatan' : _tanggal.text
                        };

                        if(_formKey2.currentState!.validate()){
                          Provider.of<Auth>(context, listen: false)
                              .buat(creds:createData);
                          Navigator.pop(context);
                        }
                      },

                      child: Text("Kirim Data"),),
                  ],
                ),
              ),
            ),
          ),]
        ),
      ),
    );
  }

  Future uploadPDF() async {
    //var dio = Dio();

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if(result!=null){
      File file = File(result.files.single.path ?? " ");

      String fileName = file.path.split('/').last;
      String filePath = file.path;
      print(fileName);

      FormData data = FormData.fromMap({
        'atas_nama' : _atas_nama.text,
        'keterangan' : _keterangan.text,
        'tanggal_pembuatan' : _tanggal.text,
        'file' : await MultipartFile.fromFile(filePath,filename: fileName)

      });

      String? token = await storage.read(key: 'token');
      Provider.of<Auth>(context, listen: false).tryToken(token: token!);
      print(token);



      //Dio.Response response = await dio().post('/posts', data: data,options: Dio.Options(headers: {'Authorization' : 'Bearer $token'}),

      Dio.Response response = await dio().post('/posts', data: data,options: Dio.Options(headers: {'Authorization' : 'Bearer $token'}),
      onSendProgress:(int sent, int total){
        print('$sent $total');
      });
      print(response);
    }else{
      print("Result is null");
    }
  }

}
