import 'package:coop_test/providers/_providers.dart';
import 'package:coop_test/models/_models.dart';
import 'package:coop_test/screens/_screens.dart';
import 'package:coop_test/utils/_utils.dart';
import 'package:flutter/material.dart';

class StoreListTile extends StatelessWidget {
  const StoreListTile({
    super.key,
    required this.store,
  });

  final Store store;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.read<PlaceTaker>().push(StoreInfoScreen.route(store: store));
      },
      title: Text(store.name),
    );
  }
}
