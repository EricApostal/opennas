import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';
import 'package:opennas/features/router/providers/router.dart';
import 'package:opennas/theme/theme.dart';
import 'package:opennas/utils/web/web_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_platform/universal_platform.dart';

void main() async {
  // Initialize stuff
  initializeWebPlatform();
  WidgetsFlutterBinding.ensureInitialized();
  initHive();

  runApp(ProviderScope(child: MaterialApp(home: const OpenNAS())));
}

void initHive() async {
  if (!UniversalPlatform.isWeb) {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dataDir = Directory('${appDocumentDir.path}/opennas/data');
    if (!dataDir.existsSync()) {
      dataDir.createSync(recursive: true);
    }
    Hive.init(dataDir.path);
  }
}

// app entrypoint
class OpenNAS extends ConsumerStatefulWidget {
  const OpenNAS({super.key});

  @override
  ConsumerState<OpenNAS> createState() => _OpenNASState();
}

class _OpenNASState extends ConsumerState<OpenNAS> {
  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final theme = ref.watch(darkThemeProvider);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarContrastEnforced: false,
      ),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).custom.colorTheme.background,
      body: KeyboardSizeProvider(
          child: MaterialApp.router(
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
        title: 'OpenNAS',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: theme.colorScheme,
          textTheme: theme.textTheme,
        ),
      )),
    );
  }
}
