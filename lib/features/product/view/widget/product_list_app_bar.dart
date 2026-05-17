import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../widgets/primary_text.dart';

class ProductListAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String categoryName;

  const ProductListAppBar({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      backgroundColor: colorScheme.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: colorScheme.onSurface,
          size: 18.sp,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: PrimaryText(
        categoryName,
        color: colorScheme.onSurface,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications_none_rounded,
            color: colorScheme.onSurface,
            size: 24.sp,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
