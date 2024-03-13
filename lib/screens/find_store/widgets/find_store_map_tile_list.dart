import 'package:coop_test/providers/_providers.dart';
import 'package:coop_test/screens/_screens.dart';
import 'package:coop_test/utils/_utils.dart';
import 'package:flutter/material.dart';

class FindStoreMapTileList extends StatelessWidget {
  const FindStoreMapTileList({
    super.key,
    required this.stores,
    required this.selectedStore,
    required this.onStoreTap,
  });

  final List<Store> stores;
  final Store? selectedStore;
  final void Function(Store store) onStoreTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: stores.map((Store store) {
          return IntrinsicHeight(
            child: _buildTile(context, store),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTile(BuildContext context, Store store) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () => onStoreTap(store),
        child: Card(
          color: (store == selectedStore) ? context.theme.primaryColor : null,
          child: SizedBox(
            width: 200,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.info_outline),
                        onPressed: () {
                          context.read<PlaceTaker>().push(StoreInfoScreen.route(store: store));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.navigation_outlined),
                        onPressed: () {
                          context.read<GenMapLauncher>().launchLoc(store.latLng);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
