import 'package:coop_test/providers/_providers.dart';
import 'package:coop_test/utils/_utils.dart';
import 'package:coop_test/widgets/_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StoreInfoScreen extends StatelessWidget {
  const StoreInfoScreen({
    super.key,
    required this.store,
  });

  static const String routeName = 'StoreInfoScreen';

  static Route<Widget> route({
    required Store store,
  }) {
    return RouteBuilder.defaultRoute(
      routeName: routeName,
      screen: StoreInfoScreen(
        store: store,
      ),
    );
  }

  final Store store;

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      appBar: AppBar(
        title: const Text('store info'),
      ),
      layout: ScrollableLayout(
        axis: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('id: ${store.id}'),
              Text('name: ${store.name}'),
              Text('lat: ${store.lat.toString()}'),
              Text('lon: ${store.lon.toString()}'),
              _buildNewsletterRow(context),
              AspectRatio(
                aspectRatio: 1,
                child: _buildMap(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsletterRow(BuildContext context) {
    return Row(
      children: [
        const Text('newsletterUrl: '),
        Flexible(
          child: Text(
            store.newsletterUrl,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: store.newsletterUrl));
          },
          icon: const Icon(Icons.copy),
        ),
        IconButton(
          onPressed: () {
            context.read<GenUrlLauncher>().launch(store.newsletterUrl);
          },
          icon: const Icon(Icons.web),
        ),
      ],
    );
  }

  Widget _buildMap(BuildContext context) {
    return Stack(
      children: [
        GenMap(
          stores: [store],
          onStoreTap: null,
          controller: null,
          selectedStores: [store],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: context.theme.colorScheme.background,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                color: context.theme.primaryColor,
                icon: const Icon(Icons.navigation_outlined),
                onPressed: () {
                  context.read<GenMapLauncher>().launchLoc(store.latLng);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
