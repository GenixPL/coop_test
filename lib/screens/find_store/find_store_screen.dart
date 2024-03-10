import 'package:coop_test/providers/_providers.dart';
import 'package:coop_test/screens/_screens.dart';
import 'package:coop_test/utils/http/http_error.dart';
import 'package:coop_test/widgets/_widgets.dart';
import 'package:coop_test/models/_models.dart';
import 'package:flutter/material.dart';

enum FindStoreScreenView {
  map,
  list,
}

class FindStoreScreen extends StatelessWidget {
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
                    child: switch (state.view) {
                      FindStoreScreenView.map => const Text('map'),
                      FindStoreScreenView.list => _buildList(state.stores),
                    },
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

  Future<void> _onInputSubmit(BuildContext context, String input) async {
    final HttpError? error = await context.read<FindStoreProvider>().fetch(StoreFetchRequestData.forInput(input));
    if (error != null) {
      print(error);
    }
  }

  void _changeView(BuildContext context, FindStoreScreenView view) {
    context.read<FindStoreProvider>().changeView(view);
  }
}
