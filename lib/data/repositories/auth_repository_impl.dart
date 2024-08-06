import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:splitz_bloc/data/models/user_model.dart';
import 'package:splitz_bloc/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  AuthRepositoryImpl(this._firebaseAuth, this._firestore, this._googleSignIn);

  @override
  Future<UserModel> signUp(
      String email, String password, String firstName, String surname) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    User? user = userCredential.user;
    if (user != null) {
      UserModel userModel = UserModel(
        id: user.uid,
        email: user.email!,
        firstName: firstName,
        surname: surname,
      );

      await _firestore.collection('users').doc(user.uid).set(userModel.toMap());

      return userModel;
    } else {
      throw Exception("User sign up failed");
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        final docRef = _firestore.collection('users').doc(user.uid);
        final doc = await docRef.get();

        if (!doc.exists) {
          UserModel newUser = UserModel(
            id: user.uid,
            email: user.email!,
            firstName: user.displayName?.split(' ')[0] ?? '',
            surname: user.displayName?.split(' ')[1] ?? '',
          );

          await docRef.set(newUser.toMap());
          return newUser;
        } else {
          return UserModel.fromMap(doc.data()!);
        }
      } else {
        throw Exception("Google sign in failed");
      }
    } else {
      throw Exception("Google sign in was aborted");
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
    }
    return null;
  }
}
