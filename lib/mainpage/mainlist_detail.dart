import 'package:arsipdian/mainpage/mainlist.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainListDetail extends StatefulWidget {
  //const MainListDetail({Key? key}) : super(key: key);
  late Map idx;
  MainListDetail({required this.idx});



  @override
  State<MainListDetail> createState() => _MainListDetailState(this.idx);
}

class _MainListDetailState extends State<MainListDetail> {

  Map idx;
  _MainListDetailState(this.idx);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            background_container(context),
            Positioned(
              top: 120,
              child: main_container(),
            )
          ],
        ),
      ),
    );
}

  Container main_container() {
    return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white
              ),
              height: 550,
              width: 340,
              child: Column(
                children: [
                  //SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Atas Nama : "+idx["atas_nama"]),
                  ),
                  Padding(//untuk garis biru
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2,
                            color: Colors.blue,),),),),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Tanggal Pembuatan : "+idx["tanggal_pembuatan"],textAlign: TextAlign.center,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("Keterangan : \n\n"+idx["keterangan"],textAlign: TextAlign.center),
                  ),
                  Padding(

                    padding: const EdgeInsets.all(20.0),
                    child:Text("Document : \n\n" + idx["document"].toString(),textAlign: TextAlign.center)
                    //!idx["document"]=="Null" ? Text("Download Document : No Document") :Text("Download Document : "+idx["document"])
                  ),

                ],
              ),
            );
  }

  Column background_container(BuildContext context) {
    return Column(
            children: [
              Container(
                width: double.infinity,
                height: 240,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext contex){return mainList();}));
                            },
                            child: Icon(Icons.arrow_back,
                            color: Colors.white,),
                          ),
                          Text('Halaman Detail',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                            ),

                          ),Icon(Icons.download,color: Colors.white,)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}

tes(){
  return Scaffold(
  appBar: AppBar(
    centerTitle: true,
    title: Text('Detail Page'),
  ),
  body: Center(child:

  Column(
  children: [
  Text('Hai'),
  Text('idx[atas_nama]')
  ],
  ), ),);
}