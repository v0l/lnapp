import 'package:flutter/widgets.dart';
import 'package:lnapp/widgets/theme/base.dart';

class BasicButton extends StatefulWidget {
  final Widget child;
  final Function onTap;

  BasicButton({this.child, this.onTap});

  @override
  State<StatefulWidget> createState() => _BasicButton();
}

class _BasicButton extends State<BasicButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(5),
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: theme.mainNavTextColor,
            width: 0.5,
          ),
          color: theme.mainNavAccent1Color,
        ),
        child: widget.child,
      ),
    );
  }
}
