import '../../../../../core/imports/common_imports.dart';

class CartBadge extends StatelessWidget {
  const CartBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final int count = state.maybeWhen(
          loaded: (cartItems, _) => cartItems.length,
          orElse: () => 0,
        );

        return Badge(
          isLabelVisible: count > 0,
          label: Text(
            count.toString(),
            style: TextStyle(
              fontSize: 10.sp,
              color: AppColors.scaffoldBackground,
            ),
          ),
          backgroundColor: AppColors.primary,
          child: IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.textMain,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/cart_screen');
            },
          ),
        );
      },
    );
  }
}
