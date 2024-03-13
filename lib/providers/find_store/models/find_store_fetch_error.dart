import 'package:coop_test/utils/_utils.dart';
import 'package:equatable/equatable.dart';

sealed class FindStoreFetchError with EquatableMixin {
  const FindStoreFetchError();
}

// There is already ongoing fetch.
//
// Right now we do not support multiple fetches at a time.
class FindStoreFetchInProgressError extends FindStoreFetchError {
  const FindStoreFetchInProgressError();

  @override
  List<Object?> get props {
    return <Object?>[];
  }
}

class FindStoreFetchFailedFetchError extends FindStoreFetchError {
  const FindStoreFetchFailedFetchError({
    required this.httpError,
  });

  final HttpError? httpError;

  @override
  List<Object?> get props {
    return <Object?>[
      httpError,
    ];
  }
}
