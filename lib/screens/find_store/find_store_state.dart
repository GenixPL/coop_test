import 'package:coop_test/models/_models.dart';
import 'package:coop_test/screens/_screens.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class FindStoreState with EquatableMixin {
  const FindStoreState({
    required this.isLoading,
    required this.stores,
    required this.view,
  });

  final bool isLoading;
  final List<Store> stores;
  final FindStoreScreenView view;

  FindStoreState copyWith({
    bool? isLoading,
    List<Store>? stores,
    FindStoreScreenView? view,
  }) {
    return FindStoreState(
      isLoading: isLoading ?? this.isLoading,
      stores: stores ?? this.stores,
      view: view ?? this.view,
    );
  }

  @mustCallSuper
  @override
  List<Object?> get props {
    return <Object?>[
      stores,
      view,
    ];
  }
}
