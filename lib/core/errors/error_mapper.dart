import '/core/imports/common_imports.dart';

class ErrorMapper {
  static String mapFirebaseError(BuildContext context, String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return context.l10n.errorEmailAlreadyInUse;
      case 'weak-password':
        return context.l10n.errorWeakPassword;
      case 'invalid-email':
        return context.l10n.errorInvalidEmail;
      case 'user-disabled':
        return context.l10n.errorUserDisabled;
      case 'user-not-found':
      case 'invalid-credential':
      case 'INVALID_LOGIN_CREDENTIALS':
        return context.l10n.loginErrorUserNotFound;
      case 'wrong-password':
        return context.l10n.errorWrongPassword;
      case 'too-many-requests':
        return context.l10n.errorTooManyRequests;
      case 'network-request-failed':
        return context.l10n.errorNetworkRequestFailed;
      case 'object-not-found':
        return "Storage bucket error. Please ensure Firebase Storage is initialized.";
      case 'unauthorized':
        return "You do not have permission to upload files.";
      default:
        return context.l10n.errorUnknown;
    }
  }
}
