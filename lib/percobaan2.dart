import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class percobaan2 extends StatefulWidget {
  const percobaan2({Key? key}) : super(key: key);

  @override
  State<percobaan2> createState() => _percobaan2State();
}

class _percobaan2State extends State<percobaan2> {

  ////////////////////////////

  bool loading = false;
  double progress = 0.0;
  final Dio dio = Dio();

  Future<bool> saveFile(String url, String fileName) async {
    Directory directory;

    try{
      if(Platform.isAndroid){
        if(await _requestPermission2(Permission.manageExternalStorage)){await _requestPermission2(Permission.manageExternalStorage);}
        if(await _requestPermission(Permission.storage)){
          directory = (await getExternalStorageDirectory())!;


        //storage/emulated/0/Android/data/com.arsipdian.arsipdian/files
          String newPath = "";
          List<String> folders =  directory.path.split("/");

          for(int x = 1 ; x<folders.length; x++){
            String folder = folders[x];
            if (folder != "Android"){
              newPath += "/"+folder;
            }else{
              break;
            }
          }
          newPath = newPath + "/ArsipDian";
          directory = Directory(newPath);
          print(directory.path);
        }else{
          return false;
        }
      }else{
        if(await _requestPermission(Permission.photos)){
          directory = await getTemporaryDirectory();
        }else{
          return false;
        }

      }

      if(!await directory.exists()){
        await directory.create(recursive: true);
      }
      if(await directory.exists()){
        File saveFile = File(directory.path+"/$fileName");
        await dio.download(url, saveFile.path,onReceiveProgress: (downloaded,totalSize){
          setState(() {
            progress = downloaded/totalSize;
          });
        });
        if(Platform.isIOS){
          await ImageGallerySaver.saveFile(saveFile.path,isReturnPathOfIOS: true);
        }
        return true;
      }
    }catch(e){
      print(e);
    }
    return false;

  }

  Future<bool> _requestPermission(Permission permission) async {
    if(await permission.isGranted){
      return true;
    }else{
      var result = await permission.request();

      if(result == PermissionStatus.granted){
        return true;
      }else {
        return false;
      }
    }

  }

  Future<bool> _requestPermission2(Permission permission) async {
    if(await permission.isGranted){
      return true;
    }else{
      var result = await permission.request();

      if(result == PermissionStatus.granted){
        return true;
      }else {
        return false;
      }
    }

  }

  downloadFile() async {

    setState(() {
      loading = true;
    });
    print("download proses");
    bool downloaded = await saveFile("https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
    //bool downloaded = await saveFile("http://10.0.2.2/arsipdian/public/api/download/3uzvHdYgIg1wneVq9ZuL4QTnXiF8Kc.jpg",
    "3uzvHdYgIg1wneVq9ZuL4QTnXiF8Kc.jpg");

    if (downloaded){
      print("File downloaded");
    }else{
      print("Problem download file");
    }

    setState(() {
      loading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Percobaan 2"),),
      body: Center(
        child: loading ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 10,
          ),
        ):ElevatedButton(onPressed: (){downloadFile();
        }, child: Text("Coba")),
      ),
    );



  }



}





