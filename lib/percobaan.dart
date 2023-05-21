import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


class percobaan extends StatefulWidget {
  const percobaan({Key? key}) : super(key: key);

  @override
  State<percobaan> createState() => _percobaanState();
}


class _percobaanState extends State<percobaan> {

  final imgUri = "http://10.0.2.2/arsipdian/public/api/download/3uzvHdYgIg1wneVq9ZuL4QTnXiF8Kc.jpg";
  bool downloading = false;
  var progress = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    downloadFile();
  }

  Future<void> downloadFile() async {

      Dio dio = Dio();
      try {
        var dir = await getExternalStorageDirectory();
        print("ini print dir");
        print(dir);
        //await dio.download(imgUri, "${dir.path}/myImage.jpg",onReceiveProgress: (rec,total){
        await dio.download(
            imgUri, "${dir}/myImage.jpg", onReceiveProgress: (rec, total) {
          print("Rec:$rec, Total: $total");

          setState(() {
            downloading = true;
            progress = ((rec / total) * 100).toStringAsFixed(0) + "%";
          });
        });
      } catch (e) {
        print(e);
      }

      setState(() {
        downloading = false;
        progress = "Completed";
      });

      print("Download Completed");
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Percobaan"),),
      body: Center(
        child: downloading?Container(
          height: 120,
          width: 200,
          child:Card(
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20,),
                Text("Downloading File : $progress",style: TextStyle(color: Colors.white),)
              ],
            ),
          ),
        ):
        ElevatedButton(onPressed: () {},child: Text("Download")),
      ),
    );
  }
}

