import 'package:equatable/equatable.dart';

import 'enums.dart';

class CryptoSymbol extends Equatable {
  final String symbol;
  final SymbolStatus status;
  final String baseAsset;
  final int baseAssetPrecision;
  final String quoteAsset;
  final int quotePrecision;
  final int quoteAssetPrecision;
  final List<OrderType> orderTypes;
  final bool icebergAllowed;
  final bool ocoAllowed;
  final bool isSpotTradingAllowed;
  final bool isMarginTradingAllowed;
  final List<dynamic> filters;
  final List<String> permissions;
  const CryptoSymbol({
    required this.symbol,
    required this.status,
    required this.baseAsset,
    required this.baseAssetPrecision,
    required this.quoteAsset,
    required this.quotePrecision,
    required this.quoteAssetPrecision,
    required this.orderTypes,
    required this.icebergAllowed,
    required this.ocoAllowed,
    required this.isSpotTradingAllowed,
    required this.isMarginTradingAllowed,
    required this.filters,
    required this.permissions,
  });

  // CryptoSymbol.fromMap(Map m)
  //     : symbol = m['symbol'] as String? ?? '',
  //       status = symbolStatusFromStr[m['status']] ?? SymbolStatus.TRADING,
  //       baseAsset = m['baseAsset'] as String? ?? '',
  //       baseAssetPrecision = m['baseAssetPrecision'] as int? ?? 0,
  //       quoteAsset = m['quoteAsset'] as String? ?? '',
  //       quotePrecision = m['quotePrecision'] as int? ?? 0,
  //       quoteAssetPrecision = m['quoteAssetPrecision'] as int? ?? 0,
  //       orderTypes = List<OrderType>.from(
  //           (m['orderTypes'] as List? ?? []).map((o) => orderTypeFromStr[o])),
  //       icebergAllowed = m['icebergAllowed'] as bool? ?? true,
  //       ocoAllowed = m['ocoAllowed'] as bool? ?? true,
  //       isSpotTradingAllowed = m['isSpotTradingAllowed'] as bool? ?? true,
  //       isMarginTradingAllowed = m['isMarginTradingAllowed'] as bool? ?? true,
  //       filters = m['filters'] as List? ?? [],
  //       permissions = (m['permissions'] as List? ?? []).cast<String>();

  factory CryptoSymbol.fromMap(Map<dynamic, dynamic> m) {
    return CryptoSymbol(
      symbol: m['symbol'] as String? ?? '',
      status: symbolStatusFromStr[m['status']] ?? SymbolStatus.TRADING,
      baseAsset: m['baseAsset'] as String? ?? '',
      baseAssetPrecision: m['baseAssetPrecision'] as int? ?? 0,
      quoteAsset: m['quoteAsset'] as String? ?? '',
      quotePrecision: m['quotePrecision'] as int? ?? 0,
      quoteAssetPrecision: m['quoteAssetPrecision'] as int? ?? 0,
      orderTypes: List<OrderType>.from(
          (m['orderTypes'] as List? ?? []).map((o) => orderTypeFromStr[o])),
      icebergAllowed: m['icebergAllowed'] as bool? ?? true,
      ocoAllowed: m['ocoAllowed'] as bool? ?? true,
      isSpotTradingAllowed: m['isSpotTradingAllowed'] as bool? ?? true,
      isMarginTradingAllowed: m['isMarginTradingAllowed'] as bool? ?? true,
      filters: m['filters'] as List? ?? [],
      permissions: m['permissions'] as List<String>? ?? [],
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      symbol,
      status,
      baseAsset,
      baseAssetPrecision,
      quoteAsset,
      quotePrecision,
      quoteAssetPrecision,
      orderTypes,
      icebergAllowed,
      ocoAllowed,
      isSpotTradingAllowed,
      isMarginTradingAllowed,
      filters,
      permissions,
    ];
  }
}
