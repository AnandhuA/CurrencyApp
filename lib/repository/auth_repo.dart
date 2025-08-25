import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //----- Login ----------
  Future<User?> login({required String email, required String password}) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? "Login failed");
    } catch (e) {
      throw AuthException(message: e.toString());
    }
  }

  //------------ Sign up ------------
  Future<User?> signUp({required String email, required String password}) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? "Sign up failed");
    } catch (e) {
      throw AuthException(message: e.toString());
    }
  }

  //----- Sign out -----
  Future<void> signOut() async {
    await _auth.signOut();
  }

  //----- Get current user ----
  User? get currentUser => _auth.currentUser;
}

class AuthException implements Exception {
  final String message;
  AuthException({required this.message});

  @override
  String toString() => message;
}
