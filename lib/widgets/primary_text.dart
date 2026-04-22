import '/core/imports/common_imports.dart';

class PrimaryText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final double? heightText;
  final double? letterSpacing;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const PrimaryText(
    this.text, {
    super.key,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.heightText,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize ?? 14.sp,
        fontFamily: 'Cairo',
        color: color ?? AppColors.textMain,
        height: heightText,
        letterSpacing: letterSpacing ?? -0.5,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }
}
