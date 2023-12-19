import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kevin Fielding',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
          useMaterial3: true,
          fontFamily: 'Coves'),
      home: const MyHomePage(title: 'KevinFielding.ca'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: ModelViewer(
          src:
              'https://storage.googleapis.com/kevinfielding/kevinfieldingca/3DME.glb',
          backgroundColor: Colors.blue,
          autoRotate: true,
          disableZoom: true,
          cameraControls: false,
          rotationPerSecond: "-500%",
          cameraOrbit: "0deg 85deg 105%",
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Row(
          children: [
            DefaultTextStyle(
              style: const TextStyle(
                  fontFamily: 'Coves',
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    "drop me a line...",
                    speed: const Duration(milliseconds: 200),
                  ),
                  TypewriterAnimatedText(
                    "this is a 3d flutter web app?",
                    speed: const Duration(milliseconds: 200),
                  ),
                  TypewriterAnimatedText(
                    "(still in progess)",
                    speed: const Duration(milliseconds: 200),
                  ),
                  TypewriterAnimatedText(
                    "i am a massive nba fan...",
                    speed: const Duration(milliseconds: 200),
                  ),
                  TypewriterAnimatedText(
                    "android dev since 2011...",
                    speed: const Duration(milliseconds: 200),
                  ),
                  TypewriterAnimatedText(
                    "iOS dev since 2017...",
                    speed: const Duration(milliseconds: 200),
                  ),
                ],
                pause: const Duration(milliseconds: 1600),
              ),
            ),
            const Spacer(),
            FloatingActionButton(
              onPressed: () =>
                  {launchUrl(Uri.parse('https://linktr.ee/kevinfielding'))},
              tooltip: 'some cool stuff i\'ve worked on',
              shape: const CircleBorder(),
              child: const Icon(Icons.work_history_outlined),
            ),
            const SizedBox(width: 15),
            FloatingActionButton(
              onPressed: () => {
                launchUrl(Uri.parse(
                    'https://storage.googleapis.com/kevinfielding/kevinfieldingca/KevinFieldingResume2024.pdf'))
              },
              tooltip: 'look at my resume',
              shape: const CircleBorder(),
              child: const Icon(Icons.description_sharp),
            ),
            const SizedBox(width: 15),
            FloatingActionButton(
              onPressed: () =>
                  {launchUrl(Uri.parse('mailto:kvnfldng@gmail.com'))},
              tooltip: 'send me an email',
              shape: const CircleBorder(),
              child: const Icon(Icons.email),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
