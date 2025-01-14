import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kfca/providers/typewriter_messages_provider.dart';
import 'package:kfca/ui/dialogs/work_dialog.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<Color> kfColors = [Colors.lime, Colors.blue, Colors.red.shade400];

  final String assetPath = (kDebugMode ? 'files/' : 'assets/files/');

  double screenWidth = 501.0;
  bool ignore3D = false;

  bool switchVal = true;
  bool switchJustHit = false;
  int index = 0;

  late FirebaseAnalytics analytics;

  @override
  void initState() {
    super.initState();
    analytics = FirebaseAnalytics.instance;
    analytics.logAppOpen();
    index = Random().nextInt(3);
  }

  Future<void> remoteLog(
      {required String eventName, Map<String, Object>? params}) async {
    if (!kDebugMode) {
      analytics.logEvent(name: eventName, parameters: params);
    }
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
      index = temp;
    });
  }

  void _onTerrainSwitch(bool val) {
    switchJustHit = true;
    analytics.logEvent(name: "terrain_switch", parameters: {"terrain_on": val});
    setState(() {
      switchVal = val;
    });
  }

  void _copyEmail() {
    remoteLog(eventName: "email");
    Clipboard.setData(const ClipboardData(text: 'kvnfldng@gmail.com')).then(
      (_) => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Copied to clipboard: kvnfldng@gmail.com',
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }

  void _onWorkClick() {
    remoteLog(eventName: "work");
    showDialog(
        context: context,
        builder: (context) {
          return WorkDialog(screenWidth: screenWidth);
        });
  }

  void _onResumeClick() {
    remoteLog(eventName: "resume");
    launchUrl(Uri.parse('${assetPath}KevinFieldingResume2025.pdf'));
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(typewriterMessagesProvider);
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kfColors[index],
      body: Listener(
        onPointerDown: (event) => {changeIndex()},
        child: ModelViewer(
          key: ValueKey('kf$switchVal'),
          src: '${assetPath}3DMELIGHT8.glb',
          autoRotate: true,
          cameraControls: !ignore3D,
          disableZoom: ignore3D,
          disablePan: true,
          disableTap: true,
          autoPlay: true,
          skyboxImage: switchVal ? '${assetPath}skybox.jpeg' : '',
          animationName: "Take 001",
          rotationPerSecond: "-500%",
          cameraOrbit: "0deg 85deg 105%",
          interactionPromptThreshold: 5000,
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
              onChanged: _onTerrainSwitch,
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
                        for (var message in messages)
                          TypewriterAnimatedText(
                            message,
                            speed: const Duration(milliseconds: 100),
                          ),
                      ],
                      isRepeatingAnimation: false,
                      pause: const Duration(
                          milliseconds: (kDebugMode ? 500 : 3000)),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                PointerInterceptor(
                  child: Row(
                    children: [
                      FloatingActionButton(
                        mouseCursor: SystemMouseCursors.basic,
                        onPressed: _onWorkClick,
                        tooltip: 'some cool stuff i\'ve worked on',
                        shape: const CircleBorder(),
                        backgroundColor: Colors.deepOrangeAccent,
                        foregroundColor: Colors.white,
                        child: const Icon(Icons.work_history_sharp),
                      ),
                      const SizedBox(width: 15),
                      FloatingActionButton(
                        mouseCursor: SystemMouseCursors.basic,
                        onPressed: _onResumeClick,
                        tooltip: 'look at my resume',
                        shape: const CircleBorder(),
                        backgroundColor: Colors.deepOrangeAccent,
                        foregroundColor: Colors.white,
                        child: const Icon(Icons.description_sharp),
                      ),
                      const SizedBox(width: 15),
                      FloatingActionButton(
                        mouseCursor: SystemMouseCursors.basic,
                        onPressed: () {
                          _copyEmail();
                        },
                        tooltip: 'send me an email',
                        shape: const CircleBorder(),
                        backgroundColor: Colors.deepOrangeAccent,
                        foregroundColor: Colors.white,
                        child: const Icon(Icons.email),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
