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
        await credential.user?.reload();
      return _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: _getErrorMessage(e));
    } catch (e) {
      throw AuthException(message: e.toString());
    }
  }

  //------------ Sign up ------------
  Future<User?> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
            await credential.user?.updateDisplayName(name);
      await credential.user?.reload();
      return _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: _getErrorMessage(e));
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

  static final Map<String, String> _errorMessages = {
    'invalid-email': "The email address is not valid.",
    'user-disabled': "This account has been disabled.",
    'user-not-found': "No user found for this email.",
    'wrong-password': "Incorrect password. Please try again.",
    'too-many-requests': "Too many login attempts. Try again later.",
    'email-already-in-use': "This email is already registered.",
    'operation-not-allowed': "This operation is not allowed.",
    'weak-password': "The password is too weak.",
    'invalid-credential':
        "The authentication credentials are invalid or have expired.",
    'account-exists-with-different-credential':
        "An account already exists with a different sign-in method.",
    'credential-already-in-use':
        "This credential is already associated with another account.",
    'invalid-verification-code': "The verification code is invalid.",
    'session-expired': "The session has expired. Please try again.",
  };

  static String _getErrorMessage(FirebaseAuthException e) =>
      _errorMessages[e.code] ??
      "An unexpected error occurred. Please try again.";
}

class AuthException implements Exception {
  final String message;
  AuthException({required this.message});

  @override
  String toString() => message;
}
