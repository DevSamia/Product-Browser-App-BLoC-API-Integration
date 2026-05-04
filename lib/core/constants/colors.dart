import '../imports/common_imports.dart';

class AppColors {
  // Common Colors
  static const Color primary = Color(0xFFFFD451);
  static const Color secondary = Color(0xFF4A69FF);
  static const Color error = Color(0xFFFF0000);
  static const Color gray = Color(0xFF9E9E9E);
  static const Color ratingStar = Color(0xFFFFE082);

  // Light Mode Colors
  static const Color textMain = Color(0xFF000000);
  static const Color textMuted = Color(0xFF434A54);
  static const Color scaffoldBackground = Color(0xFFFFFFFF);
  static const Color bgColor = Color(0xFFFDF4E7);
  static const Color fillColorStyleFromTextField = Color(0xFFF9FAFB);
  static const Color outlineInputBorderStyleFromTextField = Color(0xFFE5E7EB);
  static const Color textColorForSignInWithGoogle = Color(0xFF374151);

  // Dark Mode Colors
  static const Color darkScaffoldBackground = Color(0xFF121212);
  static const Color darkCardBackground = Color(0xFF1E1E1E);
  static const Color darkTextMain = Color(0xFFF5F5F5);
  static const Color darkTextMuted = Color(0xFFB0B0B0);
  static const Color darkFillColorStyleFromTextField = Color(0xFF2C2C2C);
  static const Color darkOutlineInputBorderStyleFromTextField = Color(
    0xFF383838,
  );

  // Legacy/Specific naming
  static const Color logoColor = scaffoldBackground;
  static const Color hintStyleFromTextField = Color(0xFF9CA3AF);
  static const Color continueText = hintStyleFromTextField;
  static const Color prefixIconStyleFromTextField = hintStyleFromTextField;
  static const Color borderColorGoogleSignInButton =
      outlineInputBorderStyleFromTextField;
  static const Color dividerSignIn = outlineInputBorderStyleFromTextField;
  static const Color textToAskAboutTheExistenceOfAnAccount = Color(0xFF6B7280);
  static const Color subTitleForLoginScreen =
      textToAskAboutTheExistenceOfAnAccount;
  static const Color checkoutButton = Color(0xFFF57C00);
  static const Color inputBorder = Color(0xFFE0E0E0);
  static const Color textSignInButton = Colors.white;
  static const Color arrowForwardRounded = Colors.white;
  static const Color screenBackground = Color(0xFFF3F7FF);
  static const Color promoBanner = secondary;
  static const Color navIconSelected = secondary;
  static const Color navIconUnselected = gray;
  static const Color searchIcon = Color(0xFF666666);
  static const Color filterIcon = secondary;
  static const Color notificationIcon = textMain;
  static const Color backIcon = textMain;
  static const Color statusBarIcons = textMain;
  static const Color appBarTitle = textMain;
  static final Color appBarDivider = Colors.grey.withValues(alpha: 0.1);
  static const Color snackBarText = Colors.white;
  static const Color passwordStrengthStrong = Color(0xFF10B981);

  // Profile Feature Colors
  static const Color profileImageBorder = Color(0xFFE5E7EB);
  static const Color profileImageBackground = Color(0xFFF3F4F6);
  static const Color accountDetailsBackground = Color(0xFFF9FAFB);
  static const Color logoutButtonText = Color(0xFFBE123C);
  static const Color logoutButtonBorder = Color(0xFFE5E7EB);
  static const Color profileHelperText = Color(0xFF6B7280);
  static const Color accountDetailsLabel = Color(0xFF9CA3AF);
  static const Color appBarIconBackground = Colors.black;
  static const Color accountDetailsValue = Color(0xFF374151);
  static final Color profileShadow = Colors.black.withValues(alpha: 0.1);
  static final Color detailCardShadow = Colors.black.withValues(alpha: 0.05);
  static const Color accountAccessDivider = Color(0xFFE5E7EB);

  static LinearGradient levelCardGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFC7E9FF), Color(0xFF9BD4FF)],
  );
}
