extension ListExtensions<T> on List<T> {
  int? tryIndexOf(T element) {
    try {
      return indexOf(element);
    } catch (e) {
      return null;
    }
  }
}
