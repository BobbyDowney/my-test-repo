import 'package:flutter/material.dart';
import 'navigationBar.dart';
import 'route_generator.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: LoginPage()
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>{
  late String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                validator: (input) {
                  if ((input == null)| (input!.isEmpty)) {
                    return 'Please type your Email';
                  }
                },
                onSaved: (input) => _email = input ?? '',
                decoration: InputDecoration(
                  labelText: 'Email'
                )
              ),
              TextFormField(
                  validator: (input) {
                    if ((input == null)| (input!.isEmpty)) {
                      return 'Please type your Password';
                    }
                  },
                  onSaved: (input) => _email = input ?? '',
                  decoration: InputDecoration(
                      labelText: 'Password'
                  ),
                obscureText: true
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.of(this.context).pushReplacementNamed('/homepage');
                },
                child: Text('Sign in')
              )
            ]
          ),
        )
      )
    );
  }
}