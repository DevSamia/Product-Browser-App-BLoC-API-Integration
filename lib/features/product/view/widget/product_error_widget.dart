import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../widgets/primary_text.dart';

class ProductErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ProductErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: colorScheme.error,
              size: 50.sp,
            ),
            AppSizes.h16,
            PrimaryText(
              message,
              fontSize: 14.sp,
              textAlign: TextAlign.center,
              color: colorScheme.onSurface,
            ),
            AppSizes.h24,
            SizedBox(
              width: 140.w,
              child: ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: PrimaryText(
                  "Retry",
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
