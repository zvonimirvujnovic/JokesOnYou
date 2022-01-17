import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jokes/state.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.white,
          colorScheme: const ColorScheme.light(
              primary: Colors.white, onPrimary: Colors.black),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Colors.orange,
              onPrimary: Colors.black,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              minimumSize: const Size(180, 32),
            ),
          )),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final joke = ref.watch(jokesProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 12,
        title: const Text("Jokes on you"),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(joke),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => ref.read(jokesProvider.notifier).nextJoke(),
                child: const Text("Next joke"),
              ),
              ElevatedButton(
                onPressed: () => ref.read(jokesProvider.notifier).addFavouriteJoke(joke),
                child: const Text("Mark as favourite"),
              ),
              ElevatedButton(
                onPressed: () => ref.read(jokesProvider.notifier).nextFavouriteJoke(),
                child: const Text("Next favourite joke"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
