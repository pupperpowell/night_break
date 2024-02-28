import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pocketbase/pocketbase.dart';

final locator = GetIt.instance;

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  const storage = FlutterSecureStorage();

  final token = await storage.read(key: 'token');
  final customAuthStore = AsyncAuthStore(
    initial: token,
    save: (String token) => storage.write(key: 'token', value: token),
    clear: () => storage.delete(key: 'token'),
  );

  final PocketBase pb =
      PocketBase('https://nightbreak.app', authStore: customAuthStore);

  locator.registerSingleton<PocketBase>(pb);
  locator.registerSingleton<FlutterSecureStorage>(storage);
}
