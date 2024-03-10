import 'package:coop_test/providers/_providers.dart';
import 'package:equatable/equatable.dart';

sealed class StoreProviderState with EquatableMixin {
  const StoreProviderState();
}

class StoreProviderLoadingState extends StoreProviderState {
  const StoreProviderLoadingState({
    required this.stores,
  });

  final List<Store> stores;

  @override
  List<Object?> get props {
    return <Object?>[
      stores,
    ];
  }
}

class StoreProviderLoadedState extends StoreProviderState {
  const StoreProviderLoadedState({
    required this.stores,
  });

  final List<Store> stores;

  @override
  List<Object?> get props {
    return <Object?>[
      stores,
    ];
  }
}
