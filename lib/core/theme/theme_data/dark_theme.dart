import '../../imports/common_imports.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Cairo',
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.dark,
    primary: AppColors.primary,
    onPrimary: Colors.black,
    secondary: AppColors.secondary,
    onSecondary: Colors.white,
    error: AppColors.error,
    surface: AppColors.darkCardBackground,
    onSurface: AppColors.darkTextMain,
    surfaceContainerHighest: const Color(0xFF2C2C2C),
    onSurfaceVariant: AppColors.darkTextMuted,
  ),
  scaffoldBackgroundColor: AppColors.darkScaffoldBackground,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.darkScaffoldBackground,
    foregroundColor: AppColors.darkTextMain,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.darkTextMain, size: 22.sp),
    titleTextStyle: TextStyle(
      color: AppColors.darkTextMain,
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
      fontFamily: 'Cairo',
    ),
  ),
  cardTheme: CardThemeData(
    color: AppColors.darkCardBackground,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.darkCardBackground,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.darkTextMuted,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.black,
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 32.sp,
      fontWeight: FontWeight.w800,
      color: AppColors.darkTextMain,
    ),
    displayMedium: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.darkTextMain,
    ),
    bodyLarge: TextStyle(fontSize: 16.sp, color: AppColors.darkTextMain),
    bodyMedium: TextStyle(fontSize: 14.sp, color: AppColors.darkTextMuted),
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
    fillColor: AppColors.darkFillColorStyleFromTextField,
    hintStyle: TextStyle(color: AppColors.darkTextMuted, fontSize: 14.sp),
    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(
        color: AppColors.darkOutlineInputBorderStyleFromTextField,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(
        color: AppColors.darkOutlineInputBorderStyleFromTextField,
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
