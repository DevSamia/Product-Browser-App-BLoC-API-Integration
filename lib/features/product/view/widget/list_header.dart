import '../../../../core/imports/common_imports.dart';
import '../../../../l10n/app_localizations.dart';

class ListHeader extends StatelessWidget {
  final int count;
  const ListHeader({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimaryText(
                l10n.discoverBest,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textMain,
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                child: PrimaryText(
                  l10n.viewAll,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondary,
                ),
              ),
            ],
          ),
          PrimaryText(
            l10n.productsFound(count),
            fontSize: 12.sp,
            color: AppColors.textMuted,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
