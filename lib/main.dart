import 'package:flutter/material.dart';
import 'package:crudfirebaseprueba/firebase_options.dart';
import 'package:crudfirebaseprueba/src/app.dart';
import 'package:crudfirebaseprueba/src/services/transports.service.dart';
import 'package:crudfirebaseprueba/src/settings/settings_controller.dart';
import 'package:crudfirebaseprueba/src/settings/settings_service.dart';
import 'package:firebase_core/firebase_core.dart'; // Assuming this contains fetchTransports()

void main() async {
  // Initialize required services
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Fetch transports during initialization
  final transports = await fetchTransports();

  runApp(
    MyApp(
      settingsController: settingsController,
      transports: transports, // Pass transports to the app
    ),
  );
}