import '../../../../../core/imports/common_imports.dart';

class ProductFeaturesRow extends StatelessWidget {
  const ProductFeaturesRow({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: _FeatureIconItem(
            icon: Icons.local_shipping_outlined,
            text: l10n.fastShipping,
          ),
        ),
        Expanded(
          child: _FeatureIconItem(
            icon: Icons.verified_user_outlined,
            text: l10n.originalGuarantee,
          ),
        ),
        Expanded(
          child: _FeatureIconItem(
            icon: Icons.history_rounded,
            text: l10n.easyReturns,
          ),
        ),
      ],
    );
  }
}

class _FeatureIconItem extends StatelessWidget {
  final IconData icon;
  final String text;
  const _FeatureIconItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: colorScheme.surfaceContainerHighest,
          child: Icon(icon, color: colorScheme.onSurface),
        ),
        AppSizes.h8,
        PrimaryText(
          text,
          fontSize: 11.sp,
          color: colorScheme.onSurfaceVariant,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
