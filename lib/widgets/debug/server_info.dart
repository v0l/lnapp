import 'package:flutter/widgets.dart';
import 'package:lnapp/widgets/base.dart';
import 'package:lnapp/widgets/bolt_loader.dart';
import 'package:lnapp/widgets/theme/base.dart';

class ServerInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final api = LNDApi.of(context);

    return BoltLoader(
      future: api.getInfo(),
      builder: (ctx, data) {
        final theme = Theme.of(context);

        return Column(
          children: <Widget>[
            _buildInfoLine(theme, "Alias", data.alias),
            _buildInfoLine(theme, "URL", data.uris.join()),
            _buildInfoLine(theme, "Version", data.version),
            _buildInfoLine(theme, "Height", data.blockHeight.toString()),
            _buildInfoLine(theme, "Chains", data.chains.join(",")),
          ],
        );
      },
    );
  }

  Widget _buildInfoLine(ThemeBase theme, String title, String value) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: theme.mainNavColor,
          ),
          child: Text(
            title,
            style: TextStyle(
              color: theme.mainNavTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: theme.mainNavAccent1Color,
          ),
          child: Text(
            value,
            style: TextStyle(
              color: theme.mainNavAccent1TextColor,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
