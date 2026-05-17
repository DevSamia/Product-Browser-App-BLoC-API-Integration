import '../../../../../core/imports/common_imports.dart';

class CartBadge extends StatelessWidget {
  const CartBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
            style: TextStyle(fontSize: 10.sp, color: colorScheme.onPrimary),
          ),
          backgroundColor: colorScheme.primary,
          child: IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: colorScheme.onSurface,
            ),
            onPressed: () {
              Navigator.pushNamed(context, cartScreen);
            },
          ),
        );
      },
    );
  }
}
