import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../../../core/global/store/user_profile_store.dart';
import '../../../auth/presentation/store/auth_store_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProfileProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: Theme.of(context).textStyle.bodySmall,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to the Home Page!\n'
                '${user.auth?.displayName}',
                style: Theme.of(context).textStyle.bodyLarge,
                textAlign: TextAlign.center,
              ),
              Text(
                '${user.auth?.email}',
                style: Theme.of(context).textStyle.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Handle logout
                  ref.read(authStoreProvider.notifier).logout();
                },
                child: const Text('logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
