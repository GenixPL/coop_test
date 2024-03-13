// ignore_for_file: avoid_print

/// Logs stuff, or not.
///
///! --- IMPORTANT ---
/// Widgets should not use this class, but the [Toaster] instead.
/// If they find themselves reaching for this class, it most
/// probably means that they are doing too much, and the logic
/// should be moved to one of the providers.
class Logger {
  const Logger({
    required String className,
  }) : _className = className;

  final String _className;

  void error(String msg) {
    print('$_className, $msg');
  }
}
