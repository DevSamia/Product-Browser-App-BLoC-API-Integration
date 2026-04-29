import '../domain/repositories/auth_repository.dart';

abstract class FirebaseAuthRepository implements AuthRepository {
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  //
  // AppUser? _mapFirebaseUserToAppUser(User? firebaseUser) {
  //   if (firebaseUser == null) return null;
  //   return AppUser(
  //     id: firebaseUser.uid,
  //     email: firebaseUser.email ?? '',
  //     username:
  //         firebaseUser.displayName ??
  //         firebaseUser.email?.split('@')[0] ??
  //         'User',
  //   );
  // }
  //
  // @override
  // Future<AppUser?> login(String email, String password) async {
  //   AppLogger.i("Attempting to login user with email: $email");
  //   try {
  //     final credential = await _firebaseAuth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //
  //     final appUser = _mapFirebaseUserToAppUser(credential.user);
  //     AppLogger.d("Login successful for UID: ${appUser?.id}");
  //     return appUser;
  //   } catch (e) {
  //     AppLogger.e("Login failed", e);
  //     throw Exception("Login failed: ${e.toString()}");
  //   }
  // }
  //
  // @override
  // Future<AppUser?> register(
  //   String email,
  //   String username,
  //   String password,
  // ) async {
  //   AppLogger.i("Attempting to register user with email: $email");
  //   try {
  //     final credential = await _firebaseAuth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //
  //     await credential.user?.updateDisplayName(username);
  //     await credential.user?.reload();
  //
  //     final updatedUser = _firebaseAuth.currentUser;
  //     final appUser = _mapFirebaseUserToAppUser(updatedUser);
  //
  //     AppLogger.d("Registration successful. UID: ${appUser?.id}");
  //     return appUser;
  //   } catch (e) {
  //     AppLogger.e("Registration failed", e);
  //     throw Exception("Registration failed: ${e.toString()}");
  //   }
  // }
  //
  // @override
  // Future<AppUser?> getCurrentUser() async {
  //   final user = _firebaseAuth.currentUser;
  //   return _mapFirebaseUserToAppUser(user);
  // }
  //
  // @override
  // Future<void> updateDisplayName(String name) async {
  //   try {
  //     await _firebaseAuth.currentUser?.updateDisplayName(name);
  //     AppLogger.d("Display name updated to: $name");
  //   } catch (e) {
  //     AppLogger.e("Failed to update display name", e);
  //     throw Exception("Profile update failed: ${e.toString()}");
  //   }
  // }
  //
  // @override
  // Future<void> logout() async {
  //   AppLogger.i("Logging out...");
  //   try {
  //     await _googleSignIn.signOut();
  //     await _firebaseAuth.signOut();
  //     AppLogger.d("Logged out successfully.");
  //   } catch (e) {
  //     AppLogger.e("Logout error", e);
  //   }
  // }
  //
  // @override
  // Future<AppUser?> signInWithGoogle() async {
  //   AppLogger.i("Starting Google Sign-In process...");
  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.();
  //
  //     if (googleUser == null) {
  //       AppLogger.w("Google Sign-In cancelled by user.");
  //       return null;
  //     }
  //
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;
  //
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       //accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //
  //     final UserCredential userCredential = await _firebaseAuth
  //         .signInWithCredential(credential);
  //
  //     AppLogger.i(
  //       "Google Sign-In successful for UID: ${userCredential.user?.uid}",
  //     );
  //     return _mapFirebaseUserToAppUser(userCredential.user);
  //   } catch (e) {
  //     AppLogger.e("Detailed Google Sign-In Error", e);
  //     rethrow;
  //   }
  // }
}
