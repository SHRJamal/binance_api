import 'package:equatable/equatable.dart';

class Trade extends Equatable {
  final String symbol;
  final int id;
  final int orderId;
  final int orderListId;
  final double price;
  final double qty;
  final double quoteQty;
  final double commission;
  final String commissionAsset;
  final DateTime time;
  final bool isBuyer;
  final bool isMaker;
  final bool isBestMatch;
  const Trade({
    required this.symbol,
    required this.id,
    required this.orderId,
    required this.orderListId,
    required this.price,
    required this.qty,
    required this.quoteQty,
    required this.commission,
    required this.commissionAsset,
    required this.time,
    required this.isBuyer,
    required this.isMaker,
    required this.isBestMatch,
  });

  factory Trade.fromMap(Map<dynamic, dynamic> m) {
    return Trade(
      symbol: m['symbol'] as String? ?? '',
      id: m['id'] as int? ?? 0,
      orderId: m['orderId'] as int? ?? 0,
      orderListId: m['orderListId'] as int? ?? 0,
      price: double.parse(m['price'] as String? ?? '0'),
      qty: double.parse(m['qty'] as String? ?? '0'),
      quoteQty: double.parse(m['quoteQty'] as String? ?? '0'),
      commission: double.parse(m['commission'] as String? ?? '0'),
      commissionAsset: m['commissionAsset'] as String? ?? '',
      time: DateTime.fromMillisecondsSinceEpoch(m['time'] as int? ?? 0),
      isBuyer: m['isBuyer'] as bool? ?? true,
      isMaker: m['isMaker'] as bool? ?? true,
      isBestMatch: m['isBestMatch'] as bool? ?? true,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      symbol,
      id,
      orderId,
      orderListId,
      price,
      qty,
      quoteQty,
      commission,
      commissionAsset,
      time,
      isBuyer,
      isMaker,
      isBestMatch,
    ];
  }

  Trade operator +(Trade o) => copyWith(
        id: id + o.id,
        commission: commission + o.commission,
        price: price + o.price,
        qty: qty + o.qty,
        quoteQty: quoteQty + o.quoteQty,
      );

  Trade copyWith({
    String? symbol,
    int? id,
    int? orderId,
    int? orderListId,
    double? price,
    double? qty,
    double? quoteQty,
    double? commission,
    String? commissionAsset,
    DateTime? time,
    bool? isBuyer,
    bool? isMaker,
    bool? isBestMatch,
  }) {
    return Trade(
      symbol: symbol ?? this.symbol,
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      orderListId: orderListId ?? this.orderListId,
      price: price ?? this.price,
      qty: qty ?? this.qty,
      quoteQty: quoteQty ?? this.quoteQty,
      commission: commission ?? this.commission,
      commissionAsset: commissionAsset ?? this.commissionAsset,
      time: time ?? this.time,
      isBuyer: isBuyer ?? this.isBuyer,
      isMaker: isMaker ?? this.isMaker,
      isBestMatch: isBestMatch ?? this.isBestMatch,
    );
  }
}
