import '../../../../../../core/imports/common_imports.dart';

class EditProfileForm extends StatefulWidget {
  final String? initialName;
  const EditProfileForm({super.key, this.initialName});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  late final TextEditingController nameController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = state.maybeWhen(
          authenticated: (user) => user,
          orElse: () => null,
        );

        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                context.l10n.publicDisplayName,
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.textMain,
              ),
              AppSizes.h12,
              CustomTextField(
                hintText: user?.username ?? "Alex Rivers",
                prefixIcon: Icons.person_outline,
                controller: nameController,
                validator: (value) =>
                    value!.isEmpty ? context.l10n.nameCannotBeEmpty : null,
              ),
              AppSizes.h8,
              PrimaryText(
                context.l10n.publicDisplayNameHelper,
                fontSize: 12.sp,
                color: AppColors.profileHelperText,
              ),
              AppSizes.h40,
              state.maybeWhen(
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
                orElse: () => SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthEvent.profileUpdateRequested(
                            username: nameController.text.trim(),
                          ),
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.description_outlined,
                          color: AppColors.textSignInButton,
                          size: 20,
                        ),
                        AppSizes.w8,
                        PrimaryText(
                          context.l10n.saveChanges,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textSignInButton,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
