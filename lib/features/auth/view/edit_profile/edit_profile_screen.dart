import '../../../../core/imports/common_imports.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: AppBar(
          backgroundColor: AppColors.scaffoldBackground,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          leadingWidth: 72.w,
          leading: Padding(
            padding: EdgeInsets.only(left: 24.w, top: 8.h, bottom: 8.h),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.appBarIconBackground,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                  color: AppColors.scaffoldBackground,
                  size: 20,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          title: PrimaryText(
            context.l10n.editProfile,
            fontSize: 20.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.textMain,
          ),
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            state.whenOrNull(
              authenticated: (_) {
                // We can show a success message here if needed,
                // but usually the UI updates naturally.
              },
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: AppColors.error,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            );
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final user = state.maybeWhen(
                authenticated: (user) => user,
                orElse: () => null,
              );

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSizes.h32,
                    EditProfileHeader(user: user),
                    AppSizes.h40,
                    AccountDetailsCard(
                      username: user?.username,
                      email: user?.email,
                    ),
                    AppSizes.h32,
                    EditProfileForm(initialName: user?.username),
                    AppSizes.h32,
                    const AccountAccessSection(),
                    AppSizes.h40,
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
