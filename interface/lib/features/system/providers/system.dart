import 'package:opennas/features/system/models/system_info.dart';
import 'package:opennas/features/system/providers/dio_client.dart';
import 'package:opennas/features/system/repositories/system.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'system.g.dart';

@riverpod
SystemRepository systemRepository(Ref ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SystemRepository(dioClient);
}

@riverpod
Future<SystemInfo> systemInfo(Ref ref) async {
  final repository = ref.watch(systemRepositoryProvider);
  return repository.getSystemInfo();
}
