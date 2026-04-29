import '../../../../core/imports/common_imports.dart';

class PromoCodeSection extends StatelessWidget {
  const PromoCodeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: const [
          Icon(Icons.add_circle, color: AppColors.primary),
          Spacer(),
          Icon(Icons.confirmation_number_outlined, color: AppColors.primary),
          SizedBox(width: 12),
          PrimaryText(
            ' ? Do you have a discount code ',
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
