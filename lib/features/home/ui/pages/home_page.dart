import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Home Page',
            style: Theme.of(context).textStyle.bodySmall,
          ),
        ),
        body: Center(
          child: Text(
            'Welcome to the Home Page!',
            style: Theme.of(context).textStyle.bodyLarge,
          ),
        ),
      );
}
