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
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
          useMaterial3: true,
          fontFamily: 'Coves'),
      home: const MyHomePage(title: 'KevinFielding.ca'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: const Center(
        child: ModelViewer(
          src: 'assets/3DME.glb',
          backgroundColor: Colors.lightBlue,
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
                  fontSize: 22,
                  fontWeight: FontWeight.w700),
              child: AnimatedTextKit(animatedTexts: [
                TypewriterAnimatedText(
                  "drop me a line...",
                  speed: const Duration(milliseconds: 200),
                ),
              ], pause: const Duration(milliseconds: 800)),
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
