import 'package:arsipdian/screens/login_screen.dart';
import 'package:arsipdian/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Arsip'),
      ),
      body: Center(
        child: Text('Home Screen'),
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
