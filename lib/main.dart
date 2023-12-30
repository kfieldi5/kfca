import 'dart:math';

import 'package:flutter/services.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
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
  List<Color> kfColors = [Colors.lime, Colors.blue, Colors.red.shade400];

  static const String skyboxUrl = 'assets/skybox.jpeg';
  bool switchVal = true;
  bool switchJustHit = false;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = Random().nextInt(3);
  }

  void changeIndex() {
    if (switchJustHit) {
      switchJustHit = false;
      return;
    }
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
          child: ModelViewer(
            key: ValueKey('kf$switchVal'),
            src: (kDebugMode)
                ? 'assets/3DMELIGHT8.glb'
                : 'https://storage.googleapis.com/kevinfielding/kevinfieldingca/3DMELIGHT8.glb',
            autoRotate: true,
            cameraControls: true,
            disableZoom: false,
            disablePan: true,
            disableTap: true,
            autoPlay: true,
            skyboxImage: switchVal
                ? (kDebugMode
                    ? 'assets/skybox.jpeg'
                    : 'https://storage.googleapis.com/kevinfielding/kevinfieldingca/skybox.jpeg')
                : '',
            animationName: "Take 001",
            rotationPerSecond: "-500%",
            cameraOrbit: "0deg 85deg 105%",
            interactionPromptThreshold: 5000,
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Switch(
              value: switchVal,
              activeColor: Colors.deepOrangeAccent,
              inactiveTrackColor: Colors.black.withAlpha(50),
              trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
              thumbIcon: MaterialStateProperty.all(
                  const Icon(Icons.imagesearch_roller, color: Colors.white)),
              onChanged: (val) {
                switchJustHit = true;
                setState(() {
                  switchVal = val;
                });
              },
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: DefaultTextStyle(
                    style: TextStyle(
                        fontFamily: 'Coves',
                        fontSize: (screenWidth < 500) ? 14 : 22,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          "welcome to my isle!",
                          speed: const Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          "this is a flutter web app",
                          speed: const Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          "(still under construction)",
                          speed: const Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          "it is runnable as an android app",
                          speed: const Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          "or an iOS app as well",
                          speed: const Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          "i am a massive nba fan...",
                          speed: const Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          "and a novice motorcycle mechanic",
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
                        TypewriterAnimatedText(
                          "i weirdly enjoy CI/CD config",
                          speed: const Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          "drop me a line...",
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                      isRepeatingAnimation: false,
                      pause: const Duration(milliseconds: 4000),
                    ),
                  ),
                ),
                Row(
                  children: [
                    FloatingActionButton(
                      onPressed: () => {
                        launchUrl(Uri.parse('https://linktr.ee/kevinfielding'))
                      },
                      tooltip: 'some cool stuff i\'ve worked on',
                      shape: const CircleBorder(),
                      backgroundColor: Colors.deepOrangeAccent,
                      foregroundColor: Colors.white,
                      child: const Icon(Icons.work_history_sharp),
                    ),
                    const SizedBox(width: 15),
                    FloatingActionButton(
                      onPressed: () => {
                        launchUrl(Uri.parse(
                            'https://storage.googleapis.com/kevinfielding/kevinfieldingca/KevinFieldingResume2024.pdf'))
                      },
                      tooltip: 'look at my resume',
                      shape: const CircleBorder(),
                      backgroundColor: Colors.deepOrangeAccent,
                      foregroundColor: Colors.white,
                      child: const Icon(Icons.description_sharp),
                    ),
                    const SizedBox(width: 15),
                    FloatingActionButton(
                      onPressed: () => {
                        Clipboard.setData(
                                const ClipboardData(text: 'kvnfldng@gmail.com'))
                            .then((_) => ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        content: Text(
                                  'Copied to clipboard: kvnfldng@gmail.com',
                                  textAlign: TextAlign.right,
                                ))))
                      },
                      tooltip: 'send me an email',
                      shape: const CircleBorder(),
                      backgroundColor: Colors.deepOrangeAccent,
                      foregroundColor: Colors.white,
                      child: const Icon(Icons.email),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
