import '../../imports/common_imports.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Cairo',
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: Colors.black,
    secondary: AppColors.secondary,
    onSecondary: Colors.white,
    error: AppColors.error,
    surface: AppColors.scaffoldBackground,
    onSurface: AppColors.textMain,
  ),
  scaffoldBackgroundColor: AppColors.scaffoldBackground,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.scaffoldBackground,
    foregroundColor: AppColors.textMain,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.textMain, size: 22.sp),
    titleTextStyle: TextStyle(
      color: AppColors.textMain,
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
      fontFamily: 'Cairo',
    ),
  ),
  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.gray,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.black,
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 32.sp,
      fontWeight: FontWeight.w800,
      color: AppColors.textMain,
    ),
    displayMedium: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.textMain,
    ),
    bodyLarge: TextStyle(fontSize: 16.sp, color: AppColors.textMain),
    bodyMedium: TextStyle(fontSize: 14.sp, color: AppColors.textMuted),
    labelLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.black,
      minimumSize: Size(double.infinity, 56.h),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      textStyle: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        fontFamily: 'Cairo',
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.fillColorStyleFromTextField,
    hintStyle: TextStyle(
      color: AppColors.hintStyleFromTextField,
      fontSize: 14.sp,
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(
        color: AppColors.outlineInputBorderStyleFromTextField,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(
        color: AppColors.outlineInputBorderStyleFromTextField,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: AppColors.error),
    ),
  ),
);
