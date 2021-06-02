import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'authentication_service.dart';

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
        child: FractionallySizedBox(
          widthFactor: .8,
          heightFactor: 1,
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
                    onSaved: (input) => _password = input ?? '',
                    decoration: InputDecoration(
                        labelText: 'Password'
                    ),
                  obscureText: true
                ),
                ElevatedButton(
                  onPressed: (){
                    signIn();
                  },
                  child: Text('Sign in')
                )
              ]
            ),
          ),
        )
      )
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState!.validate()){
      formState.save();
      try{
        context.read<AuthenticationService>().signIn(email: _email, password:_password);
        Navigator.of(this.context).pushReplacementNamed('/homepage');
      } catch(e){
        print(e.toString());
      }
    }
  }
}