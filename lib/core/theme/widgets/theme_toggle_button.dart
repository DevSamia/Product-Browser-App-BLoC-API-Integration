import '../../../core/imports/common_imports.dart';
import '../theme_bloc/theme_bloc.dart';
import '../theme_bloc/theme_event.dart';
import '../theme_bloc/theme_state.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        IconData icon;
        ThemeMode nextMode;
        String tooltip;

        if (state.themeMode == ThemeMode.light) {
          icon = Icons.dark_mode_outlined;
          nextMode = ThemeMode.dark;
          tooltip = 'Switch to Dark Mode';
        } else if (state.themeMode == ThemeMode.dark) {
          icon = Icons.brightness_auto_outlined;
          nextMode = ThemeMode.system;
          tooltip = 'Switch to System Mode';
        } else {
          icon = Icons.light_mode_outlined;
          nextMode = ThemeMode.light;
          tooltip = 'Switch to Light Mode';
        }

        return IconButton(
          tooltip: tooltip,
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return RotationTransition(turns: animation, child: child);
            },
            child: Icon(
              icon,
              key: ValueKey(icon),
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          onPressed: () {
            context.read<ThemeBloc>().add(ChangedTheme(nextMode));
          },
        );
      },
    );
  }
}
