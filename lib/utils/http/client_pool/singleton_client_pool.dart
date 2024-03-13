import 'package:coop_test/utils/_utils.dart';

/// Utilizes only one [_client].
///
/// Faster than [OneTimeClientPool] because it keeps its connections,
/// but might throw [ClientException] if the connection has expired
/// while executing a request.
/// (the exception should be caught and the request re-requested)
class SingletonClientPool extends ClientPool {
  const SingletonClientPool();

  static final Client _client = Client();

  @override
  Client getClient() {
    return _client;
  }

  @override
  void doneUsing(Client client) {
    // ignore
  }
}
