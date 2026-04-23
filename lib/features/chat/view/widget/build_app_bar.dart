import '../../../../core/imports/common_imports.dart';

PreferredSizeWidget buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.scaffoldBackground,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
      onPressed: () => Navigator.pop(context),
    ),
    titleSpacing: 0,
    title: Row(
      children: [
        const CircleAvatar(
          radius: 18,
          backgroundColor: Color(0xFFF1F4F8),
          backgroundImage: AssetImage('assets/images/user_image.png'),
        ),
        AppSizes.w12,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryText(
                "Nike Air Max 270",
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1D2125),
              ),
              Row(
                children: [
                  PrimaryText(
                    "Official Store",
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF67707A),
                  ),
                  AppSizes.w8,
                  PrimaryText(
                    "Online",
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1D2125),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 12),
        child: OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFFFFD143), width: 1.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            minimumSize: const Size(60, 32),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.open_in_new, size: 14, color: Color(0xFFB58E14)),
              AppSizes.w6,
              PrimaryText(
                "View",
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFB58E14),
              ),
            ],
          ),
        ),
      ),
    ],
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1),
      child: Container(color: const Color(0xFFE5E7EB), height: 1),
    ),
  );
}
