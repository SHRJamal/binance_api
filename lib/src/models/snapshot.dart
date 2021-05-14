import 'package:equatable/equatable.dart';

import 'binance.dart';

class SnapshotData extends Equatable {
  final List<CoinBalance> balances;
  final double totalAssetOfBtc;
  const SnapshotData({
    required this.balances,
    required this.totalAssetOfBtc,
  });

  factory SnapshotData.fromMap(Map<dynamic, dynamic> m) {
    return SnapshotData(
      balances: List<CoinBalance>.from((m['balances'] as List).map(
        (b) => CoinBalance.fromMap(b as Map),
      )),
      totalAssetOfBtc: double.parse(m['totalAssetOfBtc'] as String? ?? '0'),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [balances, totalAssetOfBtc];
}

class SnapshotVos extends Equatable {
  final SnapshotData data;
  final String type;
  final int updateTime;
  const SnapshotVos({
    required this.data,
    required this.type,
    required this.updateTime,
  });

  factory SnapshotVos.fromMap(Map<dynamic, dynamic> m) {
    return SnapshotVos(
      data: SnapshotData.fromMap(m['data'] as Map),
      type: m['type'] as String? ?? '',
      updateTime: m['updateTime'] as int? ?? 0,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [data, type, updateTime];
}
