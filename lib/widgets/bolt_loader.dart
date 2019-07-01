import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lnapp/widgets/theme/base.dart';

typedef AsyncBoltLoader<T> = Widget Function(BuildContext context, T data);

///Creates a centered element for futures to load inside
class BoltLoader<T> extends StatefulWidget {
  final Future<T> future;
  final AsyncBoltLoader<T> builder;
  final double size;
  final String loadingText;

  BoltLoader({
    @required this.future,
    @required this.builder,
    this.size = 80,
    this.loadingText = "Charging..",
  });

  @override
  State<StatefulWidget> createState() => _BoltLoader<T>();
}

class _BoltLoader<T> extends State<BoltLoader<T>> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: widget.future,
      builder: (ctx, state) {
        if (state.hasData) {
          return widget.builder(ctx, state.data);
        } else {
          return _BoltIcon(state, widget.size, widget.loadingText);
        }
      },
    );
  }
}

class _BoltIcon extends StatefulWidget {
  final AsyncSnapshot state;
  final double size;
  final String loadingText;

  _BoltIcon(this.state, this.size, this.loadingText);

  @override
  State<StatefulWidget> createState() => _BoltIconState();
}

class _BoltIconState extends State<_BoltIcon>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _controller.addListener(() => setState(() => {}));
    _animation = _controller.drive(CurveTween(curve: Curves.easeInOutBack));
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.all(
            (widget.size / 2) + ((widget.size / 10) * _animation.value)),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.mainNavAccent1Color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              widget.state.hasError
                  ? FontAwesomeIcons.pooStorm
                  : FontAwesomeIcons.bolt,
              color: theme.mainNavTextColor,
              size: widget.size,
            ),
            if (widget.loadingText != null && !widget.state.hasError)
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  widget.state.hasError
                      ? widget.state.error?.toString()
                      : widget.loadingText,
                  style: TextStyle(
                    color: theme.mainNavTextColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
