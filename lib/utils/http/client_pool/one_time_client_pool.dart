import 'package:coop_test/utils/_utils.dart';

class OneTimeClientPool extends ClientPool {
  const OneTimeClientPool();

  @override
  Client getClient() {
    return Client();
  }

  @override
  void doneUsing(Client client) {
    client.close();
  }
}
