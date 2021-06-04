import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

//Below class was copied from Robert Brunhage's tutorial (https://github.com/RobertBrunhage/flutter_firebase_auth_tutorial/blob/master/lib/authentication_service.dart)
class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }

  //Important info:
  // iOS bundle identifier: com.example.contra
  // android bundle identifier: com.example.contra

  Future<void> signUpWithEmailAndLink({required String email}) async {
    var signupLinkResults =  await _firebaseAuth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: ActionCodeSettings(
            url: 'https://contragram.page.link/createaccount',
            dynamicLinkDomain: "contragram.page.link",
            androidPackageName: "com.example.contra",
            androidInstallApp: true,
            androidMinimumVersion: '1',
            iOSBundleId: "com.example.contra",
            handleCodeInApp: true)
    );
    print('sent link to email');
    var emailLink = 'https://contragram.page.link/createaccount';
    if (_firebaseAuth.isSignInWithEmailLink('https://contragram.page.link/createaccount')){
      print('signed in with email link');
      try{
        _firebaseAuth.signInWithEmailLink(email: email, emailLink: emailLink);
      } on FirebaseAuthException catch (e){
        print(e.toString());
      }
    }
    print('did not sign in with email link...');
  }

  Future<void> getLink() async {
    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    if (data?.link != null) {
      print(data?.link);
    }
    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData? dynamicLink) async {
        final Uri? deepLink = dynamicLink?.link;
        print(deepLink);
        return deepLink;
      },
      onError: (OnLinkErrorException e) async {
        print('onLinkError');
        print(e.message);
      }
    );
  }
  Future<void> handleDynamicLink(PendingDynamicLinkData? data) async {
    Uri? deepLink = data?.link;

    if (deepLink == null){
      print('Deep link was null');
      return;
    }
    else {
      var actionCode = deepLink.queryParameters['oobCode'];
      try{
        await _firebaseAuth.checkActionCode(actionCode ?? '');
        await _firebaseAuth.applyActionCode(actionCode ?? '');
        print('action code successful!');
        print('current user is ${_firebaseAuth.currentUser}');
        _firebaseAuth.currentUser?.reload();
      } on FirebaseAuthException catch (e) {
        print('ERROR with actioncode in link');
        print(e.code);
      }
    }


  }
}
