import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../util/router/home_router.gr.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStoreProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page', style: Theme.of(context).textStyle.bodySmall),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to the Home Page!\n'
                '${authState.authEntity?.displayName}',
                style: Theme.of(context).textStyle.bodyLarge,
                textAlign: TextAlign.center,
              ),
              Text(
                '${authState.authEntity?.email}',
                style: Theme.of(context).textStyle.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
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
}
