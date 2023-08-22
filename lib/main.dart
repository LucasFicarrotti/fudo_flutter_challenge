import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:fudo_flutter_challenge/core/config/register_services.dart';
import 'package:fudo_flutter_challenge/core/routes/route_generator.dart';
import 'package:fudo_flutter_challenge/core/routes/route_names.dart';

void main() async {
  await RegisterServices.register();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fudo Flutter Challenge',
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: RouteNames.login,
    );
  }
}
