import 'package:coop_test/providers/_providers.dart';
import 'package:coop_test/utils/http/http_error.dart';
import 'package:coop_test/widgets/_widgets.dart';
import 'package:flutter/material.dart';

class FindStoreScreen extends StatelessWidget {
  const FindStoreScreen({super.key});

  static const String routeName = 'FindStoreScreen';

  static MaterialPageRoute<Widget> route() {
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
        child: Column(
          children: [
            TextField(
              onSubmitted: (String input) => _onInputSubmit(context, input),
            ),
            Container(
              color: Colors.redAccent,
              child: Consumer<StoreProvider>(
                builder: (BuildContext context, StoreProvider provider, Widget? child) {
                  final StoreProviderState state = provider.state;
                  switch (state) {
                    case StoreProviderLoadingState():
                      return const CircularProgressIndicator();

                    case StoreProviderLoadedState():
                      return Column(
                        children: [
                          const Text('LOADED'),
                          for (Store store in state.stores) Text(store.toString()),
                        ],
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onInputSubmit(BuildContext context, String input) async {
    final HttpError? error = await context.read<StoreProvider>().fetch(StoreFetchRequestData.forInput(input));
    if (error != null) {
      print(error);
    }
  }
}
