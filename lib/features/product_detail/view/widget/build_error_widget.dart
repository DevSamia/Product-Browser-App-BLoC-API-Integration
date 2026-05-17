import '../../../../core/imports/common_imports.dart';

Widget buildErrorWidget(
  BuildContext context, {
  required String message,
  required int productId,
}) {
  final colorScheme = Theme.of(context).colorScheme;

  return Center(
    child: Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 60, color: colorScheme.error),
          AppSizes.h16,
          PrimaryText(
            message,
            color: colorScheme.error,
            fontSize: 16.sp,
            textAlign: TextAlign.center,
          ),
          AppSizes.h24,
          ElevatedButton(
            onPressed: () => context.read<ProductDetailBloc>().add(
              FetchProductDetailEvent(productId),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.errorContainer,
              foregroundColor: colorScheme.onErrorContainer,
            ),
            child: const PrimaryText("Retry", fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
