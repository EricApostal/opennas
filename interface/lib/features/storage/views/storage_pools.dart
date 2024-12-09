import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StoragePoolsScreen extends ConsumerStatefulWidget {
  final String? poolId;
  const StoragePoolsScreen({
    super.key,
    this.poolId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StoragePoolsScreenState();
}

class _StoragePoolsScreenState extends ConsumerState<StoragePoolsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
