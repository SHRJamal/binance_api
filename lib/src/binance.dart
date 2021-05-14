import 'spot/binance_spot.dart';

class BinanceAPI {
  final String apiKey;
  final String apiSecret;
  late BinanceSpot spot;

  BinanceAPI({this.apiKey = "", this.apiSecret = ""}) {
    spot = BinanceSpot(apiKey: apiKey, apiSecret: apiSecret);
  }
}
