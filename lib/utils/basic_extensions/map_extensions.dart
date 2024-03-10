extension MapExtensions<T> on Map<T, dynamic> {
  R? getValue<R>(
    T? key, {
    R? defaultValueForNull,
  }) {
    final Object? value = this[key];
    if (value == null) {
      return defaultValueForNull;
    }

    try {
      switch (R) {
        // If the required type is a double, safely convert the number to double.
        // (json will drop `.0` from doubles and without this we would fail to read `5`)
        case const (double):
          return (value as num?)?.toDouble() as R?;

        // For all other types, attempt to return the value.
        default:
          return value as R?;
      }
    } catch (e) {
      return null;
    }
  }
}
