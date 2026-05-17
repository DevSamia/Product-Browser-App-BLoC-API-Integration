import '../../../../core/imports/common_imports.dart';

class ListHeader extends StatelessWidget {
  final int count;
  const ListHeader({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PrimaryText(
                  l10n.discoverBest,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              AppSizes.w8,
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: PrimaryText(
                  l10n.viewAll,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.secondary,
                ),
              ),
            ],
          ),
          PrimaryText(
            l10n.productsFound(count),
            fontSize: 12.sp,
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
