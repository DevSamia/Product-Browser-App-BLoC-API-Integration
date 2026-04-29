import '../../imports/common_imports.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Cairo',
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    surface: AppColors.darkScaffoldBackground,
    error: AppColors.error,
    onPrimary: AppColors.textMain,
    onSecondary: Colors.white,
    onSurface: AppColors.darkTextMain,
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: AppColors.darkScaffoldBackground,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.darkScaffoldBackground,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    iconTheme: const IconThemeData(color: AppColors.darkTextMain, size: 22),
    titleTextStyle: TextStyle(
      color: AppColors.darkTextMain,
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
      fontFamily: 'Cairo',
    ),
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
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textMain,
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
