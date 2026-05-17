import '../../../../../../core/imports/common_imports.dart';
import 'buildDetailRow.dart';

class AccountDetailsCard extends StatelessWidget {
  final String? username;
  final String? email;

  const AccountDetailsCard({super.key, this.username, this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimaryText(
          context.l10n.accountDetails,
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.accountDetailsLabel,
          letterSpacing: 1.2,
        ),
        AppSizes.h12,
        Container(
          decoration: BoxDecoration(
            color: AppColors.accountDetailsBackground,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            children: [
              buildDetailRow(
                icon: Icons.alternate_email,
                label: context.l10n.usernameLabel,
                value:
                    '@${username?.toLowerCase().replaceAll(' ', '_') ?? 'alex_rivers'}_cart',
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: const Divider(
                  height: 1,
                  color: AppColors.accountAccessDivider,
                ),
              ),
              buildDetailRow(
                icon: Icons.email_outlined,
                label: context.l10n.primaryEmail,
                value: email ?? 'alex.rivers@example.com',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
