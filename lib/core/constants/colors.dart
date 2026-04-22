import '../imports/common_imports.dart';

class AppColors {
  static const Color textMain = Color(0xFF000000);
  static const Color textMuted = Color(0xFF434A54);
  static const Color primary = Color(0xFFFFD451);
  static const Color error = Color(0xFFFF0000);

  static const Color scaffoldBackground = Color(0xFFFFFFFF);
  static const Color bgColor = Color(0xFFFDF4E7);
  static const Color ratingStar = Color(0xFFFFE082);
  static const Color checkoutButton = Color(0xFFF57C00);
  static const Color inputBorder = Color(0xFFE0E0E0);
  static const Color screenBackground = Color(0xFFF3F7FF);
  static const Color secondary = Color(0xFF4A69FF);
  static const Color promoBanner = secondary;
  static const Color gray = Color(0xFF9E9E9E);
  static const Color navIconSelected = secondary;
  static const Color navIconUnselected = gray;
  static const Color searchIcon = Color(0xFF666666);
  static const Color filterIcon = secondary;
  static const Color notificationIcon = textMain;
  static const Color backIcon = textMain;

  static const Color statusBarIcons = textMain;

  static LinearGradient levelCardGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFC7E9FF), Color(0xFF9BD4FF)],
  );
}
