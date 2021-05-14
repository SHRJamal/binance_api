import 'package:equatable/equatable.dart';

import 'binance.dart';
import 'snapshot.dart';

class AccountSnapshot extends Equatable {
  final int code;
  final String msg;
  final List<SnapshotVos> snapshotVos;
  const AccountSnapshot({
    required this.code,
    required this.msg,
    required this.snapshotVos,
  });

  factory AccountSnapshot.fromMap(Map<dynamic, dynamic> map) {
    return AccountSnapshot(
      code: map['code'] as int? ?? 0,
      msg: map['msg'] as String? ?? '',
      snapshotVos: List<SnapshotVos>.from(
        (map['snapshotVos'] as List?)
                ?.map((x) => SnapshotVos.fromMap(x as Map)) ??
            [],
      ),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [code, msg, snapshotVos];
}

class SpotAccountInfo extends Equatable {
  final int makerCommission;
  final int takerCommission;
  final int buyerCommission;
  final int sellerCommission;
  final bool canTrade;
  final bool canWithdraw;
  final bool canDeposit;
  final int updateTime;
  final String accountType;
  final List<CoinBalance> balances;
  final List<String> permissions;
  const SpotAccountInfo({
    required this.makerCommission,
    required this.takerCommission,
    required this.buyerCommission,
    required this.sellerCommission,
    required this.canTrade,
    required this.canWithdraw,
    required this.canDeposit,
    required this.updateTime,
    required this.accountType,
    required this.balances,
    required this.permissions,
  });

  @override
  List<Object> get props {
    return [
      makerCommission,
      takerCommission,
      buyerCommission,
      sellerCommission,
      canTrade,
      canWithdraw,
      canDeposit,
      updateTime,
      accountType,
      balances,
      permissions,
    ];
  }

  factory SpotAccountInfo.fromMap(Map<dynamic, dynamic> m) {
    return SpotAccountInfo(
      makerCommission: m['makerCommission'] as int? ?? 0,
      takerCommission: m['takerCommission'] as int? ?? 0,
      buyerCommission: m['buyerCommission'] as int? ?? 0,
      sellerCommission: m['sellerCommission'] as int? ?? 0,
      canTrade: m['canTrade'] as bool? ?? true,
      canWithdraw: m['canWithdraw'] as bool? ?? true,
      canDeposit: m['canDeposit'] as bool? ?? true,
      updateTime: m['updateTime'] as int? ?? 0,
      accountType: m['accountType'] as String? ?? '',
      balances: List<CoinBalance>.from((m['balances'] as List).map(
        (b) => CoinBalance.fromMap(b as Map),
      )),
      permissions: (m['maker'] as List? ?? []).cast<String>(),
    );
  }
}
