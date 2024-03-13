import 'package:coop_test/utils/_utils.dart';

abstract class ClientPool {
  const ClientPool();

  Client getClient();

  void doneUsing(Client client);
}
