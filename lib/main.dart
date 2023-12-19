import 'dart:math';

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
  List<Color> kfColors = [
    Colors.lime,
    Colors.blue,
    Colors.lime,
    Colors.red.shade400
  ];
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = Random().nextInt(4);
  }

  void changeIndex() {
    setState(() {
      int temp = index + 1;
      if (temp > kfColors.length - 1) {
        temp = 0;
      }
      //print("New index: $temp");
      index = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kfColors[index],
      body: Center(
        child: Listener(
          onPointerDown: (event) => {changeIndex()},
          child: const ModelViewer(
            src:
                'https://storage.googleapis.com/kevinfielding/kevinfieldingca/3DME.glb',
            backgroundColor: Colors.transparent,
            autoRotate: true,
            disableZoom: true,
            cameraControls: false,
            rotationPerSecond: "-500%",
            cameraOrbit: "0deg 85deg 105%",
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Row(
          children: [
            DefaultTextStyle(
              style: TextStyle(
                  fontFamily: 'Coves',
                  fontSize: (screenWidth < 500) ? 12 : 22,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w700),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    "drop me a line...",
                    speed: const Duration(milliseconds: 100),
                  ),
                  TypewriterAnimatedText(
                    "this is a flutter web app",
                    speed: const Duration(milliseconds: 100),
                  ),
                  TypewriterAnimatedText(
                    "(still in progess)",
                    speed: const Duration(milliseconds: 100),
                  ),
                  TypewriterAnimatedText(
                    "i am a massive nba fan...",
                    speed: const Duration(milliseconds: 100),
                  ),
                  TypewriterAnimatedText(
                    "android dev since 2011...",
                    speed: const Duration(milliseconds: 100),
                  ),
                  TypewriterAnimatedText(
                    "iOS dev since 2014...",
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                pause: const Duration(milliseconds: 4000),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                FloatingActionButton(
                  onPressed: () => {
                    launchUrl(Uri.parse('https://linktr.ee/kevinfielding'))
                  },
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
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
