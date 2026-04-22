import '../../../../../core/imports/common_imports.dart';

class ProductFeaturesRow extends StatelessWidget {
  const ProductFeaturesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _FeatureIconItem(
          icon: Icons.local_shipping_outlined,
          text: "Fast shipping",
        ),
        _FeatureIconItem(
          icon: Icons.verified_user_outlined,
          text: "Original guarantee",
        ),
        _FeatureIconItem(icon: Icons.history_rounded, text: "Easy returns"),
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
