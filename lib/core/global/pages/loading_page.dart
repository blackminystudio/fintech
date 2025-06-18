import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingPage extends ConsumerWidget {
  const LoadingPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
}
