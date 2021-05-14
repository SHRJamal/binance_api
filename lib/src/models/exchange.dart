import 'package:equatable/equatable.dart';

import '../commons/common_enums.dart';
import 'symbol.dart';

class SpotExchangeInfo extends Equatable {
  final String timezone;
  final int serverTime;
  final List<RateLimitType> rateLimits;
  final List<dynamic> exchangeFilters;
  final List<CryptoSymbol> symbols;
  const SpotExchangeInfo({
    required this.timezone,
    required this.serverTime,
    required this.rateLimits,
    required this.exchangeFilters,
    required this.symbols,
  });

  factory SpotExchangeInfo.fromMap(Map<dynamic, dynamic> m) {
    return SpotExchangeInfo(
      exchangeFilters: m['exchangeFilters'] as List? ?? [],
      rateLimits: List<RateLimitType>.from(
        (m["rateLimits"] as List? ?? []).map((b) => rateLimitFromStr[b]),
      ),
      serverTime: m["serverTime"] as int? ?? 0,
      symbols: List<CryptoSymbol>.from(
          (m['symbols'] as List<Map<String, dynamic>>? ?? [])
              .map((s) => CryptoSymbol.fromMap(s))),
      timezone: m['timezone'] as String? ?? '',
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      timezone,
      serverTime,
      rateLimits,
      exchangeFilters,
      symbols,
    ];
  }
}
