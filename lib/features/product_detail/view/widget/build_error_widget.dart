import '../../../../core/imports/common_imports.dart';

Widget buildErrorWidget(
  BuildContext context, {
  required String message,
  required int productId,
}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, size: 60, color: Colors.red),
        AppSizes.h16,
        PrimaryText(message, color: Colors.red, fontSize: 16.sp),
        AppSizes.h20,
        ElevatedButton(
          onPressed: () => context.read<ProductDetailBloc>().add(
            FetchProductDetailEvent(productId),
          ),
          child: PrimaryText("Retry"),
        ),
      ],
    ),
  );
}
