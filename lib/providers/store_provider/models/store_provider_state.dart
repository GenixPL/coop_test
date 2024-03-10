import 'package:equatable/equatable.dart';

sealed class StoreProviderState with EquatableMixin {
  const StoreProviderState();
}

class StoreProviderLoadingState extends StoreProviderState {
  const StoreProviderLoadingState();

  @override
  List<Object?> get props {
    return <Object?>[];
  }
}

class StoreProviderLoadedState extends StoreProviderState {
  const StoreProviderLoadedState({
    required this.stores,
  });

  final List<String> stores;

  @override
  List<Object?> get props {
    return <Object?>[];
  }
}
