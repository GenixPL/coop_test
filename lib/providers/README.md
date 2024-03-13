There are global provider, which should be prefixed with `glob`, and instance (/local/per-widget) providers that should be prefixed with `inst`.

In order to avoid errors when trying to access providers that are not in the tree, instance providers should be accessed only by the widgets that provide them (while global ones can be accessed by everything).
