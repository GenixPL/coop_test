import 'package:coop_test/models/_models.dart';
import 'package:coop_test/providers/_providers.dart';
import 'package:coop_test/utils/_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class GenMap extends StatelessWidget {
  const GenMap({
    super.key,
    required this.stores,
    required this.onStoreTap,
    required this.controller,
    required this.selectedStores,
  });

  final MapController? controller;
  final List<Store> stores;
  final List<Store> selectedStores;
  final void Function(Store store)? onStoreTap;

  @override
  Widget build(BuildContext context) {
    final LatLng? userLatLng = context.watch<LocationProvider>().value;

    return FlutterMap(
      mapController: controller,
      options: MapOptions(
          // Oslo
          initialCenter: switch (stores.length) {
            1 => LatLng(stores.first.lat, stores.first.lon),
            _ => LatLngMocks.oslo,
          },
          initialCameraFit: switch (stores.length) {
            0 || 1 => null,
            _ => CameraFit.coordinates(
                coordinates: stores.map((Store store) {
                  return LatLng(store.lat, store.lon);
                }).toList(),
              ),
          }),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
        MarkerLayer(
          markers: [
            if (userLatLng != null)
              Marker(
                point: userLatLng,
                child: Center(
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
            for (Store store in stores)
              Marker(
                point: LatLng(store.lat, store.lon),
                child: GestureDetector(
                  onTap: () => onStoreTap?.call(store),
                  child: switch (selectedStores.contains(store)) {
                    true => Icon(
                        Icons.place,
                        color: context.theme.primaryColor,
                      ),
                    false => const Icon(Icons.place_outlined),
                  },
                ),
              ),
          ],
        ),
      ],
    );
  }
}
