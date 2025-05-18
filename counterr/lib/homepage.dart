import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:hooks_riverpod/hooks_riverpod.dart';

// infix operation
extension OptionalInfixAddition<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this;
    if (shadow != null) {
      return shadow + (other ?? 0) as T;
    } else {
      return null;
    }
  }
}

class Counterr extends StateNotifier<int?> {
  Counterr() : super(null);
  void increment() => state = state == null ? 1 : state + 1;
  int? get value => state;
}

final CounterProvider = StateNotifierProvider<Counterr, int?>(
  (ref) => Counterr(),
);

class Homepage extends ConsumerWidget {
  const Homepage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Counterr")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Consumer(builder: (context, ref, child) {
            final count = ref.watch(CounterProvider);
            final text = count == null ? "press the button" : count.toString();
            return Text(text);
          }),
          SizedBox(
            height: 15,
          ),
          TextButton(
              onPressed: ref.read(CounterProvider.notifier).increment,
              child: Text("Increment Counter"))
        ],
      ),
    );
  }
}
