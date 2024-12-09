import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServicesDetailsScreen extends ConsumerStatefulWidget {
  final String serviceId;
  const ServicesDetailsScreen({
    super.key,
    required this.serviceId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ServicesDetailsScreenState();
}

class _ServicesDetailsScreenState extends ConsumerState<ServicesDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
