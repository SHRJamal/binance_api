import '../../binance_api.dart';

class Order {
  final String symbol;
  final int orderId;
  final int orderListId;
  final String clientOrderId;
  final double price;
  final double origQty;
  final double executedQty;
  final double cummulativeQuoteQty;
  final OrderStatus status;
  final TimeInForce timeInForce;
  final OrderType type;
  final OrderSide side;
  final double stopPrice;
  final double icebergQty;
  final int time;
  final int updateTime;
  final bool isWorking;
  final double origQuoteOrderQty;

  Order.fromMap(Map m)
      : symbol = m['symbol'] as String? ?? '',
        orderId = m['orderId'] as int? ?? 0,
        orderListId = m['orderListId'] as int? ?? 0,
        clientOrderId = m['clientOrderId'] as String? ?? '',
        price = double.parse(m['price'] as String? ?? '0'),
        origQty = double.parse(m['origQty'] as String? ?? '0'),
        executedQty = double.parse(m['executedQty'] as String? ?? '0'),
        cummulativeQuoteQty =
            double.parse(m['cummulativeQuoteQty'] as String? ?? '0'),
        status = orderStatusFromStr[m['status']] ?? OrderStatus.NEW,
        timeInForce = timeInForceFromStr[m['timeInForce']] ?? TimeInForce.GTC,
        type = orderTypeFromStr[m['type']] ?? OrderType.MARKET,
        side = orderSideFromStr[m['side']] ?? OrderSide.BUY,
        stopPrice = double.parse(m['stopPrice'] as String? ?? '0'),
        icebergQty = double.parse(m['icebergQty'] as String? ?? '0'),
        time = m['time'] as int? ?? 0,
        updateTime = m['updateTime'] as int? ?? 0,
        isWorking = m['isWorking'] as bool? ?? true,
        origQuoteOrderQty =
            double.parse(m['origQuoteOrderQty'] as String? ?? '0');
}
