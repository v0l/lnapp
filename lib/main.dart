import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:lnapp/widgets/base.dart';
import 'package:lnapp/widgets/debug/server_info.dart';
import 'package:lnapp/widgets/main_page.dart';
import 'package:lnapp/widgets/theme/base.dart';

void main() {
  //debugPaintSizeEnabled = true;
  runApp(Theme(
    theme: DarkTheme(),
    child: LNApp(),
  ));
}

class LNAppPageRouter<T> extends PageRoute<T> {
  final WidgetBuilder builder;

  LNAppPageRouter({
    @required this.builder,
    RouteSettings settings,
    this.maintainState = false,
  }) : super(settings: settings, fullscreenDialog: true);

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: builder(context),
    );
  }

  @override
  final bool maintainState;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);
}

class LNApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WidgetsApp(
      color: theme.mainNavColor,
      pageRouteBuilder: <T>(RouteSettings settings, WidgetBuilder builder) =>
          LNAppPageRouter<T>(settings: settings, builder: builder),
      routes: {
        "/": (ctx) => LNAppBase(
              child: MainPage(),
            ),
      },
    );
  }
}
