import 'package:equatable/equatable.dart';

class MakerOrder {
  final double price;
  final double quantity;

  MakerOrder.fromList(List l)
      : price = double.parse(l[0] as String? ?? '0'),
        quantity = double.parse(l[1] as String? ?? '0');
}

class OrderBook {
  final int lastUpdateId;
  final int messageOutputTime;
  final int transactionTime;
  final List<MakerOrder> bids;
  final List<MakerOrder> asks;

  OrderBook.fromMap(Map m)
      : lastUpdateId = m['lastUpdateId'] as int? ?? 0,
        messageOutputTime = m['E'] as int? ?? 0,
        transactionTime = m['T'] as int? ?? 0,
        bids = List<MakerOrder>.from(
            (m['bids'] as List<List>).map((b) => MakerOrder.fromList(b))),
        asks = List<MakerOrder>.from(
            (m['asks'] as List<List>).map((b) => MakerOrder.fromList(b)));
}

class PublicTrade extends Equatable {
  final int id;
  final double price;
  final double qty;
  final double quoteQty;
  final DateTime time;
  final bool isBuyerMaker;
  final bool isBestMatch;
  const PublicTrade({
    required this.id,
    required this.price,
    required this.qty,
    required this.quoteQty,
    required this.time,
    required this.isBuyerMaker,
    required this.isBestMatch,
  });

  PublicTrade operator +(PublicTrade o) => copyWith(
        id: id + o.id,
        price: (price + o.price) / 2,
        qty: qty + o.qty,
        quoteQty: quoteQty + o.quoteQty,
      );

  PublicTrade copyWith({
    int? id,
    double? price,
    double? qty,
    double? quoteQty,
    DateTime? time,
    bool? isBuyerMaker,
    bool? isBestMatch,
  }) {
    return PublicTrade(
      id: id ?? this.id,
      price: price ?? this.price,
      qty: qty ?? this.qty,
      quoteQty: quoteQty ?? this.quoteQty,
      time: time ?? this.time,
      isBuyerMaker: isBuyerMaker ?? this.isBuyerMaker,
      isBestMatch: isBestMatch ?? this.isBestMatch,
    );
  }

  factory PublicTrade.fromMap(Map<dynamic, dynamic> m) {
    return PublicTrade(
      id: m['id'] as int? ?? 0,
      price: double.parse(m['price'] as String? ?? '0'),
      qty: double.parse(m['qty'] as String? ?? '0'),
      quoteQty: double.parse(m['quoteQty'] as String? ?? '0'),
      time: DateTime.fromMillisecondsSinceEpoch(m['time'] as int),
      isBuyerMaker: m['isBuyerMaker'] as bool? ?? false,
      isBestMatch: m['isBestMatch'] as bool? ?? true,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      price,
      qty,
      quoteQty,
      time,
      isBuyerMaker,
      isBestMatch,
    ];
  }
}

class AggregatedTrade {
  final int id;
  final double price;
  final double qty;
  final int firstTradeId;
  final int lastTradeId;
  final int timestamp;
  final bool isBuyerMaker;
  final bool isBestMatch;

  AggregatedTrade.fromMap(Map m)
      : id = m['a'] as int? ?? 0,
        price = double.parse(m['p'] as String? ?? '0'),
        qty = double.parse(m['q'] as String? ?? '0'),
        firstTradeId = m['f'] as int? ?? 0,
        lastTradeId = m['l'] as int? ?? 0,
        timestamp = m['T'] as int? ?? 0,
        isBuyerMaker = m['m'] as bool? ?? true,
        isBestMatch = m['M'] as bool? ?? true;
}

class Kline {
  final DateTime openTime;
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;
  final int closeTime;

  final double quoteVolume;
  final int tradesCount;
  final double takerBase;
  final double takerQuote;

  Kline.fromList(List c)
      : openTime = DateTime.fromMillisecondsSinceEpoch(c.first as int? ?? 0),
        open = double.parse(c[1] as String? ?? '0'),
        high = double.parse(c[2] as String? ?? '0'),
        low = double.parse(c[3] as String? ?? '0'),
        close = double.parse(c[4] as String? ?? '0'),
        volume = double.parse(c[5] as String? ?? '0'),
        closeTime = c[6] as int? ?? 0,
        tradesCount = c[8] as int? ?? 0,
        quoteVolume = double.parse(c[7] as String? ?? '0'),
        takerBase = double.parse(c[9] as String? ?? '0'),
        takerQuote = double.parse(c[10] as String? ?? '0');
}
