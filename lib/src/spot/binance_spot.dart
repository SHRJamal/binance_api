import '../../binance_api.dart';

class BinanceSpot extends Binance {
  BinanceSpot({
    String apiSecret = "",
    String apiKey = "",
  }) : super(
          endpoint: 'api.binance.com',
          prefix: 'api/v3',
          apiKey: apiKey,
          apiSecret: apiSecret,
        );

  Future<SpotExchangeInfo> exchangeInfo() => sendRequest(
        path: 'api/v3/exchangeInfo',
        securityType: SecurityType.NONE,
        type: RequestType.GET,
      ).then((r) => SpotExchangeInfo.fromMap(r as Map));

  Future<double> avgPrice(String symbol) => sendRequest(
        path: 'api/v3/avgPrice',
        securityType: SecurityType.NONE,
        type: RequestType.GET,
        params: {'symbol': symbol},
      ).then((r) => double.parse(r['price'] as String? ?? ''));

  Future<Order> queryOrder(
    String symbol, {
    int? orderId,
    int? origClientOrderId,
    int? recvWindow,
  }) async {
    final params = {
      'symbol': symbol,
      if (orderId != null) 'orderId': '$orderId',
      if (origClientOrderId != null) 'origClientOrderId': '$origClientOrderId',
      if (recvWindow != null) 'recvWindow': '$recvWindow',
    };
    final r = await sendRequest(
      path: 'api/v3/order',
      securityType: SecurityType.USER_DATA,
      type: RequestType.GET,
      timestampNeeded: true,
      params: params,
    ) as Map;
    return Order.fromMap(r);
  }

  Future<List<Order>> allOpenOrders({String? symbol, int? recvWindow}) async {
    final params = {
      if (symbol != null) 'symbol': symbol,
      if (recvWindow != null) 'recvWindow': '$recvWindow',
    };
    final m = await sendRequest(
      path: 'api/v3/openOrders',
      securityType: SecurityType.USER_DATA,
      type: RequestType.GET,
      timestampNeeded: true,
      params: params,
    );
    return List<Order>.from((m as List).map((o) => Order.fromMap(o as Map)));
  }

  Future<List<Order>> allOrders(
    String symbol, {
    int? orderId,
    int? startTime,
    int? endTime,
    int? limit,
    int? recvWindow,
  }) async {
    final params = {
      'symbol': symbol,
      if (orderId != null) 'orderId': '$orderId',
      if (startTime != null) 'startTime': '$startTime',
      if (endTime != null) 'endTime': '$endTime',
      if (limit != null) 'limit': '$limit',
      if (recvWindow != null) 'recvWindow': '$recvWindow',
    };
    final r = await sendRequest(
      path: 'api/v3/allOrders',
      securityType: SecurityType.USER_DATA,
      type: RequestType.GET,
      timestampNeeded: true,
      params: params,
    );
    return List<Order>.from((r as List).map((o) => Order.fromMap(o as Map)));
  }

  Future<SpotAccountInfo> accountInfo({int? recvWindow}) async {
    final params = {
      if (recvWindow != null) 'recvWindow': '$recvWindow',
    };
    final m = await sendRequest(
      path: 'api/v3/account',
      securityType: SecurityType.USER_DATA,
      type: RequestType.GET,
      timestampNeeded: true,
      params: params,
    ) as Map;
    return SpotAccountInfo.fromMap(m);
  }

  Future<List<Trade>> tradeList(
    String symbol, {
    int? startTime,
    int? endTime,
    int? fromId,
    int? limit,
    int? recvWindow,
  }) async {
    final params = {
      'symbol': symbol,
      if (startTime != null) 'startTime': '$startTime',
      if (endTime != null) 'endTime': '$endTime',
      if (fromId != null) 'fromId': '$fromId',
      if (limit != null) 'limit': '$limit',
      if (recvWindow != null) 'recvWindow': '$recvWindow',
    };
    return sendRequest(
      path: 'api/v3/myTrades',
      securityType: SecurityType.USER_DATA,
      type: RequestType.GET,
      timestampNeeded: true,
      params: params,
    ).then(
      (m) => List<Trade>.from(
        (m as List).map((o) => Trade.fromMap(o as Map)),
      ),
    );
  }

  Future<AccountSnapshot> accountSnapshot(
    String type, {
    int? startTime,
    int? endTime,
    int? limit,
    int? recvWindow,
  }) async {
    final params = {
      'type': type,
      if (startTime != null) 'startTime': '$startTime',
      if (endTime != null) 'endTime': '$endTime',
      if (limit != null) 'limit': '$limit',
      if (recvWindow != null) 'recvWindow': '$recvWindow',
    };
    final a = await sendRequest(
      path: 'sapi/v1/accountSnapshot',
      securityType: SecurityType.USER_DATA,
      type: RequestType.GET,
      timestampNeeded: true,
      params: params,
    ) as Map;
    return AccountSnapshot.fromMap(a);
  }
}
