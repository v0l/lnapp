import 'package:flutter/widgets.dart';
import 'package:lnapp/lnd/base.dart';
import 'package:lnapp/widgets/bolt_loader.dart';
import 'package:lnapp/widgets/button.dart';
import 'package:lnapp/widgets/theme/base.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LNDApi extends InheritedWidget {
  final LNDApiBase _api;

  LNDApi(this._api, {Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static LNDApiBase of(BuildContext ctx) =>
      (ctx.inheritFromWidgetOfExactType(LNDApi) as LNDApi)?._api;
}

class LNAppBase extends StatefulWidget {
  final Widget child;

  LNAppBase({@required this.child});

  @override
  State<StatefulWidget> createState() => _LNAppBase();
}

class _LNAppBase extends State<LNAppBase> {
  LNDApiBase _api;

  @override
  void initState() {
    super.initState();

    _api = LNDApiBase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LNDApi(
      _api,
      child: BoltLoader<bool>(
        future: _api.hasConfig(),
        builder: (ctx, data) {
          if (data) {
            return _buildPage(theme);
          } else {
            return _buildSetupPage(theme);
          }
        },
      ),
    );
  }

  Widget _buildPage(ThemeBase theme) {
    return Column(
      children: <Widget>[
        Expanded(
          child: widget.child,
        ),
        _buildBottomMenu(theme),
      ],
    );
  }

  Widget _buildSetupPage(ThemeBase theme) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(50),
      decoration: BoxDecoration(
        color: theme.mainNavColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              bottom: 50,
            ),
            child: Icon(
              FontAwesomeIcons.bolt,
              size: 100,
              color: theme.mainNavTextColor,
            ),
          ),
          BasicButton(
            child: Text("LND"),
          ),
          BasicButton(
            child: Text("c-lightning"),
          ),
          BasicButton(
            child: Text("Eclair"),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomMenu(ThemeBase theme) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.mainNavColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildRowButton(theme, FontAwesomeIcons.exchangeAlt, "Channels"),
          _buildRowButton(theme, FontAwesomeIcons.infoCircle, "Node Info"),
        ],
      ),
    );
  }

  Widget _buildRowButton(ThemeBase theme, IconData icon, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          color: theme.mainNavTextColor,
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text(
            text,
            style: TextStyle(
              color: theme.mainNavTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
