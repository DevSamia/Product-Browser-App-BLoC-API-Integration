import '../../../core/imports/common_imports.dart';
import '../../../core/theme/widgets/theme_toggle_button.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
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
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      // استخدام لون السطح من الثيم
      backgroundColor: colorScheme.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 70,
      leading: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: IconButton(
          icon: Icon(
            Icons.notifications_none_rounded,
            color: colorScheme.onSurface,
            size: 26,
          ),
          onPressed: () {
            AppLogger.d("🔔 UI: User clicked notifications");
          },
        ),
      ),
      actions: [
        const ThemeToggleButton(),
        IconButton(
          icon: Icon(
            Icons.search_rounded,
            color: colorScheme.onSurface,
            size: 26,
          ),
          onPressed: () {},
        ),
        AppSizes.w10,
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.bolt_rounded,
              color: colorScheme.onPrimaryContainer,
              size: 22,
            ),
          ),
        ),
      ],
      centerTitle: true,
      title: PrimaryText(
        context.l10n.categories,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w800,
        fontSize: 18.sp,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
