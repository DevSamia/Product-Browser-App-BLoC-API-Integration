import '../../../../../../core/imports/common_imports.dart';

class SocialDivider extends StatelessWidget {
  const SocialDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: AppColors.dividerSignIn, thickness: 1),
        ),
        Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: PrimaryText(
              context.l10n.orContinueWith,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.continueText,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const Expanded(
          child: Divider(color: AppColors.dividerSignIn, thickness: 1),
        ),
      ],
    );
  }
}
