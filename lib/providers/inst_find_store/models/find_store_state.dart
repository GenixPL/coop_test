import 'package:coop_test/providers/_providers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class FindStoreState with EquatableMixin {
  const FindStoreState({
    required this.isLoading,
    required this.stores,
  });

  static const FindStoreState initial = FindStoreState(
    isLoading: false,
    stores: <Store>[],
  );

  final bool isLoading;
  final List<Store> stores;

  FindStoreState copyWith({
    bool? isLoading,
    List<Store>? stores,
  }) {
    return FindStoreState(
      isLoading: isLoading ?? this.isLoading,
      stores: stores ?? this.stores,
    );
  }

  @mustCallSuper
  @override
  List<Object?> get props {
    return <Object?>[
      isLoading,
      stores,
    ];
  }
}
