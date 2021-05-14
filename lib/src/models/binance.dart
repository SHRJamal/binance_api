import 'package:equatable/equatable.dart';

class CoinBalance extends Equatable {
  final String asset;
  final double free;
  final double locked;
  const CoinBalance({
    required this.asset,
    required this.free,
    required this.locked,
  });

  factory CoinBalance.fromMap(Map<dynamic, dynamic> m) {
    return CoinBalance(
      asset: m['asset'] as String? ?? '',
      free: double.parse(m['free'] as String? ?? '0'),
      locked: double.parse(m['locked'] as String? ?? '0'),
    );
  }

  String freeUSD(double avrPrice) => (free * avrPrice).toStringAsFixed(2);
  String lockedUSD(double avrPrice) => (locked * avrPrice).toStringAsFixed(2);
  String get qty => (free + locked).toStringAsFixed(2);
  String qtyQuote(double avrPrice) => ((free + locked) * avrPrice).toStringAsFixed(2);
  @override
  bool get stringify => true;

  @override
  List<Object> get props => [asset, free, locked];
}
