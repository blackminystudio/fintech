import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: Center(
          child: Text(
            'Welcome to the Home Page!',
            style: Theme.of(context).textStyle.headingSmall,
          ),
        ),
      );
}
