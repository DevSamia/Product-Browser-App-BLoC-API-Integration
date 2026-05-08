import '../../../../../core/imports/common_imports.dart';
import '../../../../../l10n/app_localizations.dart';

class ProductFeaturesRow extends StatelessWidget {
  const ProductFeaturesRow({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _FeatureIconItem(
          icon: Icons.local_shipping_outlined,
          text: l10n.fastShipping,
        ),
        _FeatureIconItem(
          icon: Icons.verified_user_outlined,
          text: l10n.originalGuarantee,
        ),
        _FeatureIconItem(
          icon: Icons.history_rounded, 
          text: l10n.easyReturns,
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
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.inputBorder,
          child: Icon(icon, color: AppColors.textMain),
        ),
        AppSizes.h8,
        PrimaryText(text, fontSize: 11.sp, color: AppColors.textMuted),
      ],
    );
  }
}
