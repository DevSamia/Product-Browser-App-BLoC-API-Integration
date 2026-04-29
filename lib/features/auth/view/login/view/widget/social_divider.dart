import '../../../../../../core/imports/common_imports.dart';

class SocialDivider extends StatelessWidget {
  const SocialDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.dividerSignIn, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: PrimaryText(
            'OR CONTINUE WITH',
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.continueText,
          ),
        ),
        const Expanded(
          child: Divider(color: AppColors.dividerSignIn, thickness: 1),
        ),
      ],
    );
  }
}
