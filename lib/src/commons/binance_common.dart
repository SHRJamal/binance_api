import 'dart:convert' as convert;
import 'dart:io';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

import 'common_classes.dart';
import 'common_enums.dart';
import 'exceptions.dart';

abstract class Binance {
  final String endpoint;
  final String prefix;
  final String apiKey;
  final String apiSecret;

  Binance({
    required this.endpoint,
    required this.prefix,
    this.apiKey = "",
    this.apiSecret = "",
  });

  Future<dynamic> sendRequest({
    required String path,
    required SecurityType securityType,
    required RequestType type,
    bool timestampNeeded = false,
    Map<String, String> params = const {},
  }) async {
    if (timestampNeeded) {
      params['timestamp'] = (DateTime.now().millisecondsSinceEpoch).toString();
    }

    if (securityType == SecurityType.TRADE ||
        securityType == SecurityType.USER_DATA) {
      final tempUri = Uri.https('', '', params);
      final queryParams = tempUri.toString().substring(7);
      final messageBytes = convert.utf8.encode(queryParams);
      final key = convert.utf8.encode(apiSecret);
      final hmac = Hmac(sha256, key);
      final digest = hmac.convert(messageBytes);
      final signature = hex.encode(digest.bytes);
      params['signature'] = signature;
    }

    final header = <String, String>{
      HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
    };
    if (securityType != SecurityType.NONE) header["X-MBX-APIKEY"] = apiKey;

    final uri = Uri.https(endpoint, path, params);
    http.Response? response;

    switch (type) {
      case RequestType.GET:
        response = await http.get(
          uri,
          headers: securityType == SecurityType.NONE ? null : header,
        );
        break;
      case RequestType.POST:
        response = await http.post(
          uri,
          headers: header,
        );
        break;
      case RequestType.DELETE:
        response = await http.delete(
          uri,
          headers: header,
        );
        break;
      case RequestType.PUT:
        response = await http.put(uri);
        break;
      default:
    }

    final result = convert.jsonDecode(response?.body ?? '');
    if (result is Map) {
      if (result.containsKey("code") && result['code'] != 200) {
        throw BinanceApiException(
          result["msg"] as String? ?? '',
          result["code"] as int? ?? 404,
        );
      }
    }

    return result;
  }

  Future<bool> testPing() => sendRequest(
        path: '$prefix/ping',
        securityType: SecurityType.NONE,
        type: RequestType.GET,
      ).then((r) => true);

  Future<int> serverTime() async {
    final res = await sendRequest(
      path: '$prefix/time',
      securityType: SecurityType.NONE,
      type: RequestType.GET,
    );
    return res['serverTime'] as int;
  }

  Future<OrderBook> orderBook(String symbol, {int? limit}) async {
    final params = {"symbol": symbol};
    if (limit != null) params['limit'] = limit.toString();
    final res = await sendRequest(
      path: '$prefix/depth',
      securityType: SecurityType.NONE,
      type: RequestType.GET,
      params: params,
    );
    return OrderBook.fromMap(res as Map);
  }

  Future<List<PublicTrade>> tradesList(String symbol, {int? limit}) async {
    final params = {
      "symbol": symbol,
      if (limit != null) 'limit': '$limit',
    };
    return sendRequest(
      path: '$prefix/trades',
      securityType: SecurityType.NONE,
      type: RequestType.GET,
      params: params,
    ).then(
      (r) => List<PublicTrade>.from(
        (r as List).map((t) => PublicTrade.fromMap(t as Map)),
      ),
    );
  }

  Future<List<PublicTrade>> historicalTrades(String symbol,
      {int? limit, int? fromId}) async {
    final params = {
      "symbol": symbol,
      if (limit != null) 'limit': '$limit',
      if (fromId != null) 'fromId': '$fromId',
    };
    final r = await sendRequest(
      path: '$prefix/historicalTrades',
      securityType: SecurityType.MARKET_DATA,
      type: RequestType.GET,
      params: params,
    ) as Map;
    return List<PublicTrade>.from(
      r.values.map(
        (t) => PublicTrade.fromMap(t as Map),
      ),
    );
  }

  Future<List<AggregatedTrade>> aggregatedTrades(
    String symbol, {
    int? fromId,
    int? startTime,
    int? endTime,
    int? limit,
  }) async {
    final params = {
      "symbol": symbol,
      if (fromId != null) 'fromId': fromId.toString(),
      if (startTime != null) 'startTime': startTime.toString(),
      if (endTime != null) 'endTime': endTime.toString(),
      if (limit != null) 'limit': limit.toString(),
    };
    final r = await sendRequest(
      path: '$prefix/aggTrades',
      securityType: SecurityType.NONE,
      type: RequestType.GET,
      params: params,
    ) as Map;
    return List<AggregatedTrade>.from(r.values.map(
      (t) => AggregatedTrade.fromMap(t as Map),
    ));
  }

  Future<List<Kline>> candlestickData(
    String symbol,
    Interval interval, {
    int? startTime,
    int? endTime,
    int? limit,
  }) async {
    final params = {
      'symbol': symbol,
      'interval': intervalToStr[interval] ?? '',
      if (startTime != null) 'startTime': '$startTime',
      if (endTime != null) 'endTime': '$endTime',
      if (limit != null) 'limit': '$limit',
    };
    final r = await sendRequest(
      path: '$prefix/klines',
      securityType: SecurityType.NONE,
      type: RequestType.GET,
      params: params,
    ) as Map;
    return List<Kline>.from(r.values.map(
      (t) => Kline.fromList(t as List),
    ));
  }
}
