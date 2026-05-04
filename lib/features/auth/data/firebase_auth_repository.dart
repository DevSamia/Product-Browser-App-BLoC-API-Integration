import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../core/imports/common_imports.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.standard();

  AppUser? _mapFirebaseUserToAppUser(User? firebaseUser) {
    if (firebaseUser == null) return null;
    return AppUser(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      username:
          firebaseUser.displayName ??
          firebaseUser.email?.split('@')[0] ??
          'User',
      profileImageUrl: firebaseUser.photoURL,
    );
  }

  @override
  Future<AppUser?> login(String email, String password) async {
    AppLogger.i("Attempting to login user with email: $email");
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final appUser = _mapFirebaseUserToAppUser(credential.user);
      AppLogger.d("Login successful for UID: ${appUser?.id}");
      return appUser;
    } on FirebaseAuthException catch (e) {
      AppLogger.e("Login failed: ${e.code}", e);
      throw e.code;
    } catch (e) {
      AppLogger.e("Login failed", e);
      throw "An unexpected error occurred during login";
    }
  }

  @override
  Future<AppUser?> register(
    String email,
    String username,
    String password,
  ) async {
    AppLogger.i("Attempting to register user with email: $email");
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user?.updateDisplayName(username);
      await credential.user?.reload();
      final updatedUser = _firebaseAuth.currentUser;
      final appUser = _mapFirebaseUserToAppUser(updatedUser);
      AppLogger.d("Registration successful. UID: ${appUser?.id}");
      return appUser;
    } on FirebaseAuthException catch (e) {
      AppLogger.e("Registration failed: ${e.code}", e);
      throw e.code;
    } catch (e) {
      AppLogger.e("Registration failed", e);
      throw "An unexpected error occurred during account creation";
    }
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    return _mapFirebaseUserToAppUser(user);
  }

  @override
  Future<void> updateDisplayName(String name) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();
        AppLogger.d("Display name updated to: $name");
      }
    } catch (e) {
      AppLogger.e("Failed to update display name", e);
      throw Exception("Profile update failed: ${e.toString()}");
    }
  }

  @override
  Future<void> logout() async {
    AppLogger.i("Logging out...");
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      AppLogger.d("Logged out successfully.");
    } catch (e) {
      AppLogger.e("Logout error", e);
    }
  }

  @override
  Future<AppUser?> signInWithGoogle() async {
    AppLogger.i("Starting Google Sign-In process...");
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signInSilently();
      if (googleUser == null) {
        AppLogger.i("Silent sign-in failed, prompting user for sign-in...");
        googleUser = await _googleSignIn.signIn();
        if (googleUser == null) {
          AppLogger.w("Google Sign-In cancelled by user.");
          return null;
        }
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      AppLogger.i(
        "Google Sign-In successful for UID: ${userCredential.user?.uid}",
      );
      return _mapFirebaseUserToAppUser(userCredential.user);
    } on FirebaseAuthException catch (e) {
      AppLogger.e("Google Sign-In Error: ${e.code}", e);
      throw e.code;
    } catch (e) {
      AppLogger.e("Detailed Google Sign-In Error", e);
      throw "An error occurred during Google Sign-In";
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    AppLogger.i("Attempting to send password reset email to: $email");
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      AppLogger.d("Password reset email sent successfully.");
    } on FirebaseAuthException catch (e) {
      AppLogger.e("Password reset failed: ${e.code}", e);
      throw e.code;
    } catch (e) {
      AppLogger.e("Password reset failed", e);
      throw "An unexpected error occurred during password reset";
    }
  }

  @override
  Future<void> updateProfileImage(File imageFile) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) throw "User not logged in";

    AppLogger.i("Uploading profile image for UID: ${user.uid}");
    try {
      final storageRef = _storage.ref().child('profile_images/${user.uid}.jpg');
      
      // Upload with metadata to ensure correct content type
      final uploadTask = storageRef.putFile(
        imageFile,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      // Wait for task to complete and get snapshot
      final snapshot = await uploadTask;
      
      // Get download URL from the completed task's reference
      final downloadUrl = await snapshot.ref.getDownloadURL();

      await user.updatePhotoURL(downloadUrl);
      await user.reload();
      
      AppLogger.d("Profile image updated successfully. URL: $downloadUrl");
    } on FirebaseException catch (e) {
      AppLogger.e("Firebase Storage Error [${e.code}]: ${e.message}", e);
      throw e.code;
    } catch (e) {
      AppLogger.e("Failed to update profile image", e);
      throw "An error occurred during image upload";
    }
  }
}
