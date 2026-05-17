import '/core/imports/common_imports.dart';

class PrimaryText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final double? heightText;
  final double? letterSpacing;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const PrimaryText(
    this.text, {
    super.key,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.heightText,
    this.overflow,
    this.maxLines,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        overflow: overflow,
        fontSize: fontSize ?? 14.sp,
        fontFamily: 'Cairo',
        // Use colorScheme.onSurface as default for text
        color: color ?? Theme.of(context).colorScheme.onSurface,
        height: heightText,
        letterSpacing: letterSpacing ?? -0.5,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }
}
