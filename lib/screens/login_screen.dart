import 'package:arsipdian/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _usernameController.text = 'rahasia';
    _passwordController.text = 'rahasia';
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                validator: (value) => value!.isEmpty ? 'please enter valid username' : null
              ),
              TextFormField(
                  controller: _passwordController,
                  validator: (value) => value!.isEmpty ? 'please enter valid password' : null
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(

                  onPressed: (){

                    Map creds = {
                      'username' : _usernameController.text,
                      'password' : _passwordController.text
                    };

                    if(_formKey.currentState!.validate()){
                      Provider.of<Auth>(context, listen: false)
                          .login(creds:creds);
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Login",style: TextStyle(color: Colors.white),)



              ),
            ],
          ),
        ),
      ),
    );
  }
}

