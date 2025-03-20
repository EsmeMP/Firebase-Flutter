import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Iniciar sesion con google
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // obtener los detalled de autenticacion
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    // crar una nueva credencial
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Regresar la credencial de acceso
    return await _firebaseAuth.signInWithCredential(credential);
  }

  // cerrar sesion
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
