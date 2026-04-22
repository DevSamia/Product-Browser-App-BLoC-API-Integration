import '/core/imports/common_imports.dart';

class AppTheme {
  static const Color primaryColor = AppColors.scaffoldBackground;
  static const Color white = Colors.white;

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: white,
      useMaterial3: true,
      fontFamily: 'Cairo',
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: white),
        titleTextStyle: TextStyle(
          color: white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodyLarge: TextStyle(fontSize: 14.sp, color: Colors.black),
      ),
    );
  }
}
