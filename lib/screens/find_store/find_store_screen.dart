import 'package:coop_test/dep_factory/_dep_factory.dart';
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

class FindStoreScreen extends StatefulWidget {
  const FindStoreScreen({
    super.key,
  });

  static const String routeName = 'FindStoreScreen';

  static Route<Widget> route() {
    return RouteBuilder.defaultRoute(
      routeName: routeName,
      screen: const FindStoreScreen(),
    );
  }

  @override
  State<FindStoreScreen> createState() => _FindStoreScreenState();
}

class _FindStoreScreenState extends State<FindStoreScreen> {
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
    return ScreenWrapper(
      appBar: AppBar(
        title: const Text('find store'),
      ),
      layout: ExpandedLayout(
        child: ChangeNotifierProvider(
          create: (_) => context.read<DepFactory>().buildFindStoreProvider(),
          child: Consumer<InstFindStoreProvider>(
            builder: (BuildContext context, InstFindStoreProvider provider, Widget? child) {
              final FindStoreState state = provider.value;

              return Column(
                children: [
                  _buildTextField(context, state.isLoading),
                  Expanded(
                    child: IndexedStack(
                      index: switch (_view) {
                        _FindStoreScreenView.map => 0,
                        _FindStoreScreenView.list => 1,
                      },
                      children: [
                        Stack(
                          children: [
                            _buildMap(state.stores),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: _buildMapTiles(state.stores),
                            ),
                          ],
                        ),
                        _buildList(state.stores),
                      ],
                    ),
                  ),
                  ScrollableLayout(
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
                                context.read<GlobLocationProvider>().value = LatLngMocks.oslo;
                              },
                            ),
                            GenTextButton(
                              text: 'find nearby',
                              onTap: () => _findStoresThroughLocation(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, bool isLoading) {
    return SearchBar(
      onSubmitted: (String input) => _findStores(context, StoreFetchRequestData.forInput(input)),
      trailing: [
        if (isLoading) const CircularProgressIndicator(),
      ],
    );
  }

  Widget _buildList(List<Store> stores) {
    return ListView(
      children: [
        for (Store store in stores) StoreListTile(store: store),
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

  Widget _buildMapTiles(List<Store> stores) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: stores.map((Store store) {
          return IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                onTap: () => _selectStore(store),
                child: Card(
                  color: (store == _selectedStore) ? context.theme.primaryColor : null,
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
            ),
          );
        }).toList(),
      ),
    );
  }

  Future<void> _findStoresThroughLocation(BuildContext context) async {
    final GetLocationResult result = await context.read<GlobLocationProvider>().getLocation();

    if (!mounted) {
      return;
    }

    final LatLng? latLng = result.latLng;
    if (latLng == null) {
      context.read<Toaster>().showError(GetLocationErrorMappers.getLocationErrorToString(result.error));
      return;
    }

    await _findStores(context, StoreFetchRequestData.forLatLng(latLng));
  }

  Future<void> _findStores(BuildContext context, StoreFetchRequestData storeFetchRequestData) async {
    final FindStoreFetchResult result = await context.read<InstFindStoreProvider>().fetch(storeFetchRequestData);

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
