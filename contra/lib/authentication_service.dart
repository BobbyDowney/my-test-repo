import 'package:firebase_auth/firebase_auth.dart';

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
  // android bundle identifier

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
    return signupLinkResults;
  }
}
