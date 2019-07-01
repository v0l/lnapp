import 'package:grpc/grpc.dart';
import 'package:lnapp/proto/rpc.pbgrpc.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LNDApiBase {
  LightningClient _client;
  CallOptions _baseOptions;

  Future<bool> hasConfig() async {
    return (await loadMacaroon()) != null;
  }

  Future<String> loadCert() async {
    final storage = new FlutterSecureStorage();
    return await storage.read(key: "tls.cert");
  }

  Future<String> loadMacaroon() async {
    final storage = new FlutterSecureStorage();
    return await storage.read(key: "macaroon");
  }
  
  Future<bool> connect(
    String host, {
    int port,
  }) async {
    final certFile = await rootBundle.load("assets/tls.cert");
    final macaroon = await rootBundle.loadString("assets/admin.macroon");

    //setup call options to always contain the macaroon
    _baseOptions = CallOptions(
      metadata: {
        "macaroon": macaroon,
      },
    );

    final channel = ClientChannel(
      host,
      port: 10010,
      options: ChannelOptions(
        credentials: ChannelCredentials.secure(
            certificates: certFile.buffer.asUint8List(),
            onBadCertificate: (c, h) {
              return true; //allow invalid hostnames
            }),
      ),
    );
    _client = LightningClient(channel);

    return true;
  }

  Future<GetInfoResponse> getInfo() async {
    return await _client.getInfo(
      GetInfoRequest(),
      options: _baseOptions,
    );
  }

  Future<ChannelBalanceResponse> channelBalance() async {
    return await _client.channelBalance(
      ChannelBalanceRequest(),
      options: _baseOptions,
    );
  }

  Future<WalletBalanceResponse> walletBalance() async {
    return await _client.walletBalance(
      WalletBalanceRequest(),
      options: _baseOptions,
    );
  }
}
