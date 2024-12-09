class RouterRefreshStream {
  static Stream<void> get stream => Stream.periodic(const Duration(minutes: 1));
}
