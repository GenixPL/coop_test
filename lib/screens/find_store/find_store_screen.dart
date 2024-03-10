import 'package:coop_test/providers/_providers.dart';
import 'package:coop_test/screens/_screens.dart';
import 'package:coop_test/utils/http/http_error.dart';
import 'package:coop_test/widgets/_widgets.dart';
import 'package:coop_test/models/_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

enum FindStoreScreenView {
  map,
  list,
}

class FindStoreScreen extends StatefulWidget {
  const FindStoreScreen({
    super.key,
  });

  static const String routeName = 'FindStoreScreen';

  static MaterialPageRoute<Widget> route() {
    // TODO(genix): move
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) {
        return const FindStoreScreen();
      },
    );
  }

  @override
  State<FindStoreScreen> createState() => _FindStoreScreenState();
}

class _FindStoreScreenState extends State<FindStoreScreen> {
  final MapController _mapController = MapController();

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
          create: (_) => FindStoreProvider(),
          child: Consumer<FindStoreProvider>(
            builder: (BuildContext context, FindStoreProvider provider, Widget? child) {
              final FindStoreState state = provider.value;

              return Column(
                children: [
                  _buildTextField(context, state.isLoading),
                  Expanded(
                    child: IndexedStack(
                      index: switch (state.view) {
                        FindStoreScreenView.map => 0,
                        FindStoreScreenView.list => 1,
                      },
                      children: [
                        _buildMap(state.stores),
                        _buildList(state.stores),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      GenTextButton(
                        text: 'map',
                        onTap: () => _changeView(context, FindStoreScreenView.map),
                      ),
                      GenTextButton(
                        text: 'list',
                        onTap: () => _changeView(context, FindStoreScreenView.list),
                      ),
                    ],
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
      onSubmitted: (String input) => _onInputSubmit(context, input),
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
    return FlutterMap(
      mapController: _mapController,
      options: const MapOptions(
        // Oslo
        initialCenter: LatLng(59.9139, 10.7522),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
        MarkerLayer(
          markers: [
            for (Store store in stores)
              Marker(
                point: LatLng(store.lat, store.lon),
                child: GestureDetector(
                  onTap: () {
                    print(store.name);
                  },
                  child: Icon(Icons.place_outlined),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Future<void> _onInputSubmit(BuildContext context, String input) async {
    final List<Store>? stores = await context.read<FindStoreProvider>().fetch(StoreFetchRequestData.forInput(input));
    if (stores != null && stores.isNotEmpty) {
      _mapController.fitCamera(CameraFit.coordinates(
        padding: const EdgeInsets.all(24),
        coordinates: [
          for (Store store in stores) LatLng(store.lat, store.lon),
        ],
      ));
    }
  }

  void _changeView(BuildContext context, FindStoreScreenView view) {
    context.read<FindStoreProvider>().changeView(view);
  }
}
