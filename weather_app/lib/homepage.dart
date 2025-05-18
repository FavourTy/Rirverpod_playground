// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Homepage extends ConsumerWidget {
  const Homepage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Weather App"),
      ),
      body: Center(
        child: Text(
          "",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
