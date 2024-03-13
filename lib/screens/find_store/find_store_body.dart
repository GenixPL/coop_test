import 'package:coop_test/providers/_providers.dart';
import 'package:coop_test/screens/_screens.dart';
import 'package:coop_test/utils/_utils.dart';
import 'package:coop_test/widgets/_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

enum _FindStoreScreenView {
  map,
  list,
}

class FindStoreBody extends StatefulWidget {
  const FindStoreBody({
    super.key,
    required this.state,
    required this.onFindStores,
  });

  final FindStoreState state;
  final Future<FindStoreFetchResult> Function(StoreFetchRequest request) onFindStores;

  @override
  State<FindStoreBody> createState() => _FindStoreBodyState();
}

class _FindStoreBodyState extends State<FindStoreBody> {
  final MapController _mapController = MapController();
  Store? _selectedStore;
  _FindStoreScreenView _view = _FindStoreScreenView.map;

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandedLayout(
      child: Column(
        children: [
          _buildSearch(widget.state.isLoading),
          Expanded(
            child: IndexedStack(
              index: switch (_view) {
                _FindStoreScreenView.map => 0,
                _FindStoreScreenView.list => 1,
              },
              children: [
                // 0
                Stack(
                  children: [
                    _buildMap(widget.state.stores),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: FindStoreMapTileList(
                        stores: widget.state.stores,
                        selectedStore: _selectedStore,
                        onStoreTap: _selectStore,
                      ),
                    ),
                  ],
                ),
                // 1
                _buildList(widget.state.stores),
              ],
            ),
          ),
          _buildBottomOptions(),
        ],
      ),
    );
  }

  Widget _buildSearch(bool isLoading) {
    return SearchBar(
      onSubmitted: (String input) => _findStores(StoreFetchRequest.forInput(input)),
      trailing: [
        if (isLoading) const CircularProgressIndicator(),
      ],
    );
  }

  Widget _buildList(List<Store> stores) {
    return ListView(
      children: [
        for (Store store in stores)
          ListTile(
            onTap: () {
              context.read<PlaceTaker>().push(StoreInfoScreen.route(store: store));
            },
            title: Text(store.name),
          ),
      ],
    );
  }

  Widget _buildMap(List<Store> stores) {
    final Store? selectedStore = _selectedStore;

    return GenMap(
      stores: stores,
      onStoreTap: _selectStore,
      controller: _mapController,
      selectedStores: [
        if (selectedStore != null) selectedStore,
      ],
    );
  }

  Widget _buildBottomOptions() {
    return ScrollableLayout(
      axis: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GenTextButton(
                text: 'map',
                onTap: () => _changeView(_FindStoreScreenView.map),
              ),
              GenTextButton(
                text: 'list',
                onTap: () => _changeView(_FindStoreScreenView.list),
              ),
            ],
          ),
          Row(
            children: [
              GenTextButton(
                text: 'fake position',
                onTap: () {
                  // ignore: invalid_use_of_protected_member
                  context.read<GlobLocationProvider>().value = LatLngMocks.oslo;
                },
              ),
              GenTextButton(
                text: 'find nearby',
                onTap: _findStoresThroughLocation,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _findStoresThroughLocation() async {
    final GetLocationResult result = await context.read<GlobLocationProvider>().getLocation();

    if (!mounted) {
      return;
    }

    final LatLng? latLng = result.latLng;
    if (latLng == null) {
      context.read<Toaster>().showError(GetLocationErrorMappers.getLocationErrorToString(result.error));
      return;
    }

    await _findStores(StoreFetchRequest.forLatLng(latLng));
  }

  Future<void> _findStores(StoreFetchRequest storeFetchRequestData) async {
    final FindStoreFetchResult result = await widget.onFindStores(storeFetchRequestData);

    if (!mounted) {
      return;
    }

    final List<Store>? stores = result.stores;
    if (stores == null) {
      context.read<Toaster>().showError(FindStoreFetchErrorMappers.findStoreFetchErrorToString(result.error));
      return;
    }

    if (stores.isNotEmpty) {
      _mapController.fitCamera(CameraFit.coordinates(
        padding: const EdgeInsets.all(24),
        coordinates: [
          for (Store store in stores) LatLng(store.lat, store.lon),
        ],
      ));
    } else {
      context.read<Toaster>().showInfo('No stores have been found for this location.');
    }
  }

  void _changeView(_FindStoreScreenView view) {
    _view = view;
    setState(() {});
  }

  void _selectStore(Store store) {
    _selectedStore = store;
    _mapController.move(store.latLng, _mapController.camera.zoom);
    setState(() {});
  }
}
