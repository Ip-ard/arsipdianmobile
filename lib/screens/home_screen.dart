import 'package:arsipdian/mainpage/mainlist.dart';
import 'package:arsipdian/percobaan.dart';
import 'package:arsipdian/screens/login_screen.dart';
import 'package:arsipdian/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../percobaan2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final storage = new FlutterSecureStorage();

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
      appBar: AppBar(
        title: Text('Arsip'),
      ),
      body:
      Column(
        children: <Widget>[
          Center(
            child: Text('Home Screen')
          ),

          ElevatedButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> mainList()));
                },
              child: Text('Searching data')),

          ElevatedButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> percobaan2()));
          }, child: Text("Percobaan"))


        ],
      ),

      drawer: Drawer(
        child: Consumer<Auth>(builder: (context, auth,child){
          if (! auth.authenticated){
            return ListView(
              children: [
                ListTile(
                  title: Text("Login"),
                  leading: Icon(Icons.login),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginScreen()));
                  },
                ),
              ],
            );
          }else{
            return ListView(
              children: [
                DrawerHeader(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50,
                      ),
                      SizedBox(height: 10,),
                      Text(auth.user!.username.toString(),style: TextStyle(color: Colors.white),)
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),

                ListTile(
                  title: Text("Logout"),
                  leading: Icon(Icons.logout),
                  onTap: (){
                    Provider.of<Auth>(context, listen: false)
                        .logout();
                  },
                )
              ],
            );
          }

        }),
      ),
    );
  }
}
