import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotFoundScreen extends ConsumerStatefulWidget {
  const NotFoundScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotFoundScreenState();
}

class _NotFoundScreenState extends ConsumerState<NotFoundScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
