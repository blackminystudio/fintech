import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home/util/router/home_router.gr.dart';

import '../../store/auth_store_provider.dart';

@RoutePage()
class DisabledUserPage extends ConsumerWidget {
  const DisabledUserPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Your account has been disabled due to violation.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    await ref.read(authStoreProvider.notifier).logout();
                    await context.router.replace(const HomeRoute());
                  },
                  child: const Text('logout'),
                ),
              ],
            ),
          ),
        ),
      );
}
