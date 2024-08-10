import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_task9/pages/home.dart';
import 'package:provider_task9/providers/post_details_provider.dart';
import 'package:provider_task9/providers/posts_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (ctx) => PostsProvider()),
    ChangeNotifierProvider(create: (ctx) => PostDetailsProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
