import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:labs2/home.dart';
import 'package:labs2/models/favorites_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_push_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await FirebasePushNotifications.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeView(),
    );
  }
}

