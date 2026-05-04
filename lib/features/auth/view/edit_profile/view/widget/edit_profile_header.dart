import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:product_browser_app/core/imports/common_imports.dart';

class EditProfileHeader extends StatelessWidget {
  final AppUser? user;
  const EditProfileHeader({super.key, this.user});

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );

      if (pickedFile != null) {
        if (context.mounted) {
          context.read<AuthBloc>().add(
            AuthEvent.profileImageUpdateRequested(image: File(pickedFile.path)),
          );
        }
      }
    } catch (e) {
      AppLogger.e("Error picking image", e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () => _pickImage(context),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.profileImageBorder,
                      width: 1.5,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 55.r,
                    backgroundColor: AppColors.profileImageBackground,
                    backgroundImage: user?.profileImageUrl != null
                        ? NetworkImage(user!.profileImageUrl!)
                        : const NetworkImage(
                            'https://img.freepik.com/free-psd/3d-illustration-person-with-glasses_23-2149436185.jpg',
                          ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(6.r),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.scaffoldBackground,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.profileShadow,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    color: AppColors.scaffoldBackground,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
          AppSizes.h16,
          PrimaryText(
            user?.username ?? '',
            fontSize: 24.sp,
            fontWeight: FontWeight.w900,
            color: AppColors.textMain,
          ),
        ],
      ),
    );
  }
}
