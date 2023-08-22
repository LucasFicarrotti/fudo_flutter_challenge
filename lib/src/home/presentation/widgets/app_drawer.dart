import 'package:flutter/material.dart';

import '../../../../core/routes/route_names.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Menu',
                    style: textTheme.titleLarge,
                  ),
                  const Divider(),
                ],
              ),
              TextButton.icon(
                label: const Text('Cerrar sesión'),
                icon: const Icon(Icons.logout_rounded),
                onPressed: () =>
                    Navigator.of(context).pushNamed(RouteNames.login),
              )
            ],
          ),
        ),
      ),
    );
  }
}
