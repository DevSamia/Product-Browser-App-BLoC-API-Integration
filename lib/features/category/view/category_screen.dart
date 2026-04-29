import '../../../core/imports/common_imports.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLogger.d("🎨 UI: Building CategoryScreen...");

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: const _CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppSizes.h30,
              const HeroSection(),
              AppSizes.h30,
              const CategoryGrid(),
              AppSizes.h30,
              const PromoBanner(),
              AppSizes.h30,
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.scaffoldBackground,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 70,
      leading: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: IconButton(
          icon: const Icon(
            Icons.notifications_none_rounded,
            color: AppColors.textMuted,
            size: 26,
          ),
          onPressed: () {
            AppLogger.d("🔔 UI: User clicked notifications in CategoryScreen");
          },
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.search_rounded,
            color: AppColors.textMuted,
            size: 26,
          ),
          onPressed: () {
            AppLogger.d("🔍 UI: User clicked search in CategoryScreen");
          },
        ),
        AppSizes.w10,
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: InkWell(
            onTap: () => AppLogger.d("⚡ UI: User clicked Bolt Action icon"),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.textMuted,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: const Icon(
                Icons.bolt_rounded,
                color: AppColors.scaffoldBackground,
                size: 22,
              ),
            ),
          ),
        ),
      ],
      centerTitle: true,
      title: PrimaryText(
        'Categories',
        color: const Color(0xFF1A1A1A),
        fontWeight: FontWeight.w800,
        fontSize: 18.sp,
        letterSpacing: -0.5,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
