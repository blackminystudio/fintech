import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/auth/store/auth_store.dart';

// TODO: Need to be redesigned

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
                  onPressed: () {
                    ref.read(authStoreProvider.notifier).logout();
                  },
                  child: const Text('logout'),
                )
              ],
            ),
          ),
        ),
      );
}
