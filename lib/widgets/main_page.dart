import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lnapp/lnd/base.dart';
import 'package:lnapp/proto/rpc.pbgrpc.dart';
import 'package:lnapp/widgets/base.dart';
import 'package:lnapp/widgets/bolt_loader.dart';
import 'package:lnapp/widgets/theme/base.dart';
import 'package:tuple/tuple.dart';
import 'package:intl/intl.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _BalanceInfo(),
        ),
        Expanded(
          flex: 2,
          child: _HistoryInfo(),
        ),
      ],
    );
  }
}

class _BalanceInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final api = LNDApi.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.mainNavColor,
      ),
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: BoltLoader<Tuple2<WalletBalanceResponse, ChannelBalanceResponse>>(
        size: 40,
        loadingText: null,
        future: _waitBalances(api),
        builder: (ctx, data) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(
                      FontAwesomeIcons.unlink,
                      size: 10,
                      color: theme.mainNavTextColor,
                    ),
                  ),
                  Text(
                    "${NumberFormat.decimalPattern().format(data.item2.balance)} sats",
                    style: TextStyle(
                      fontSize: 30,
                      color: theme.mainNavTextColor,
                    ),
                  ),
                ],
              ),
              Text(
                  "${NumberFormat.currency().format((data.item2.balance.toDouble() / pow(10, 8)) * 11400)}",
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.mainNavTextColor,
                      )),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Icon(
                        FontAwesomeIcons.link,
                        size: 10,
                        color: theme.mainNavTextColor,
                      ),
                    ),
                    Text(
                      "${NumberFormat.decimalPattern().format(data.item1.totalBalance)} sats",
                      style: TextStyle(
                        fontSize: 20,
                        color: theme.mainNavTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                  "${NumberFormat.currency().format((data.item1.totalBalance.toDouble() / pow(10, 8)) * 11400)}",
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.mainNavTextColor,
                      )),
            ],
          );
        },
      ),
    );
  }

  Future<Tuple2<WalletBalanceResponse, ChannelBalanceResponse>> _waitBalances(
      LNDApiBase api) async {
    final rsp = await Future.wait([api.walletBalance(), api.channelBalance()]);

    return Tuple2<WalletBalanceResponse, ChannelBalanceResponse>(
      rsp.first,
      rsp.last,
    );
  }
}

class _HistoryInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
