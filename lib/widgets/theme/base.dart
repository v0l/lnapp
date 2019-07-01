import 'package:flutter/widgets.dart';

abstract class ThemeBase {
  Color get mainNavColor;
  Color get mainNavTextColor;

  Color get mainNavAccent1Color;
  Color get mainNavAccent1TextColor;
}

class DarkTheme implements ThemeBase {
  @override
  Color get mainNavColor => const Color(0xFF121b29);

  @override
  Color get mainNavTextColor => const Color(0xFFD3D6DC);

  @override
  Color get mainNavAccent1Color => const Color(0xFF192539);

  @override
  Color get mainNavAccent1TextColor => const Color(0xFFD3D6DC);
}

class LightTheme {}

class Theme extends InheritedWidget {
  final ThemeBase theme;

  Theme({
    @required this.theme,
    Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static ThemeBase of(BuildContext ctx) =>
      (ctx.inheritFromWidgetOfExactType(Theme) as Theme).theme;
}
