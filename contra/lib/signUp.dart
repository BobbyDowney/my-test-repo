import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'authentication_service.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

//Using tutorial from https://medium.com/firebase-developers/dive-into-firebase-auth-on-flutter-email-and-link-sign-in-e51603eb08f8 to do link signing


class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: SignupPage()
    );
  }
}

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}
class _SignupPageState extends State<SignupPage>{
  late String _email, _invitecode, _emailcode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    handleDynamicLinks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Sign up - unfinished', style: TextStyle(fontSize: 40)),
                      TextFormField(
                        initialValue: '1234', //to be removed -- just made testing easier
                          validator: (input) {
                            if ((input == null)| (input!.isEmpty)) {
                              return 'Please type your invite code';
                            }
                          },
                          onSaved: (input) => _invitecode = input ?? '',
                          decoration: InputDecoration(
                              labelText: 'Invite code'
                          ),
                          obscureText: true
                      ),
                      TextFormField(
                        initialValue: 'jacob.am.cremers@gmail.com', //to be removed -- just made testing easier
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
                      SizedBox(height: 30),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                                onPressed: (){
                                  signUpWithEmailLink();
                                },
                                child: Text('Sign up')
                            ),
                            SizedBox(width: 20),
                            Text('or'),
                            TextButton(
                                child: Text('Log in'),
                                onPressed: (){
                                  Navigator.of(context).pushReplacementNamed('/signin');
                                })
                          ]
                      )
                    ]
                ),
              ),
            )
        )
    );
  }
  Future handleDynamicLinks() async {
    //STARTUP FROM DYNAMIC LINK LOGIC
    //Get initial dynamic link if the app is started using the link
    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink(); //equivalent to the authstatechanges() in authentication service

    _handleDeepLink(data);

    //INTO FOREGROUND FROM DYNAMIC LINK LOGIC
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLinkData) async {
          _handleDeepLink(dynamicLinkData);
        },
        onError: (OnLinkErrorException e) async {
          print('Dynamic link failed: ${e.message}');
        }
    );
  }

  void _handleDeepLink(PendingDynamicLinkData? data) {
    final Uri? deepLink = data?.link;
    if (deepLink != null) {
      print('_handleDeepLink | deepLink: $deepLink');
      Provider.of<AuthenticationService>(context).checkLink(deepLink);
    }

  }

  Future<void> signUpWithEmailLink() async {
    final formState = _formKey.currentState;
    if (formState!.validate()){
      formState.save();
      try{
        await context.read<AuthenticationService>().signUpWithEmailAndLink(email: _email);
        // final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
        // print(data?.link);
        // await context.read<AuthenticationService>().handleDynamicLink(data);
      } catch(e){
        print(e.toString());
      }
    }
  }
}

