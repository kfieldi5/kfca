import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:kfca/firebase_options.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Color> kfColors = [Colors.lime, Colors.blue, Colors.red.shade400];

  final String assetPath = (kDebugMode ? 'files/' : 'assets/files/');

  double screenWidth = 501.0;
  bool ignore3D = false;

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

  Widget insertDivider() {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Divider(thickness: 1, color: Colors.black12),
    );
  }

  Widget projectBlurb(String imagePath, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(imagePath, fit: BoxFit.cover, height: 42),
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              desc,
              style: TextStyle(fontSize: (screenWidth < 500 ? 12 : 15)),
              maxLines: 10,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery
        .of(context)
        .size
        .width;

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
              onChanged: (val) {
                switchJustHit = true;
                FirebaseAnalytics.instance.logEvent(name: "terrainSwitch", parameters: {"value": val});
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
                          "this is a flutter app.",
                          speed: const Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          "written in dart, kotlin, swift and js.",
                          speed: const Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          "(still under construction)",
                          speed: const Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          "it is hosted and unit tested via Firebase,",
                          speed: const Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          "but is also runnable as an Android or iOS app",
                          speed: const Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          "...some stuff about me...",
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
                          "i've been an android dev since 2011...",
                          speed: const Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          "and an iOS dev since 2014...",
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
                        onPressed: () {
                          FirebaseAnalytics.instance.logEvent(name: "showWork");
                          showAnimatedDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return PointerInterceptor(
                                child: Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: (screenWidth < 500) ? 20 : 72,
                                        horizontal: (screenWidth < 500)
                                            ? 20
                                            : screenWidth / 4),
                                    padding: const EdgeInsets.all(20),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFd2b48c),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                    ),
                                    child: DefaultTextStyle(
                                      style: TextStyle(
                                          fontFamily: 'Coves',
                                          fontSize: (screenWidth < 500)
                                              ? 14
                                              : 22,
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                      child: Stack(children: [
                                        ListView(
                                          children: [
                                            projectBlurb(
                                                "files/soap.webp",
                                                "SOAP Audio (2023)",
                                                "I started making some audio manipulation plugins with a couple pals to increase our workflow when editing hobbyist podcasts and tutorial videos. We only have a single plugin available for download right now."),
                                            insertDivider(),
                                            projectBlurb(
                                                "files/lumos1.webp",
                                                "Lumosity (2017-2023)",
                                                "I had the pleasure of working on this beast of an app on and off for 6 years and helped transition it to its latest form: a Flutter iOS/Android app. For the time being, I think the company is keeping the web experience in JS. The mobile app has had 3 different types of game engines embedded, three major redesign overhauls and loads of features over the nearly 2 decades it's been around. Working closely with the neuroscience team and understanding the 'why' behind the games was definitely a big highlight."),
                                            insertDivider(),
                                            projectBlurb(
                                                "files/mind.webp",
                                                "Lumosity Mind (2021)",
                                                "This was the Lumos Labs venture into the meditation app market and we learned a ton from it. Product lessons aside, the engineering core created its first cross platform UI-kit and services bundle that handled creating a uniform Login and Settings experience across our mobile apps. Eventually this app was converted to Flutter too."),
                                            insertDivider(),
                                            projectBlurb(
                                                "files/figment.webp",
                                                "Figment by Lumosity (2020)",
                                                "An app that challenged the way creativity was sparked and used routine and a large variety or prompts to keep users engaged and having fun! First app to use our cross platform bundles from Mind."),
                                            insertDivider(),
                                            projectBlurb(
                                                "files/pono.webp",
                                                "PonoMusic & PonoPlayer (2014-2017)",
                                                "Getting to not only work with one of my biggest musical heroes but also having to advise against his will was a surreal experience I look back on fondly. Neil Young is a tough cookie but he was an understanding CEO if presented the information well. Despite the product not having much of a shelf life we still like to think we played somewhat of a role in Tidal, Apple Music and Spotify all upping the quality of their streamed content."),
                                            insertDivider(),
                                            projectBlurb(
                                                "files/poker.webp",
                                                "Zynga Poker (2011-2014)",
                                                "I'm so proud that this product has withstood the test of time. We innovated so much on such a basic game and everyone on the team wore all the hats. The biggest highlight was probably leading the 'Multi-Table Tournament' project which allowed players to play in massive online tournaments with real world prizes. Server jumping, cross-server chat, economy syncing - so much cool stuff."),
                                            insertDivider(),
                                            projectBlurb(
                                                "files/farmville2.webp",
                                                "Farmville 2 by Zynga (2013)",
                                                "We worked so hard and played even harder on this team lol. When I think back to the Vegas trips or other very 2010s-Silicon-Valley type stuff we did (after pulling days, sometimes weeks, of all nighters) I'm just glad I did it when I was in my early 20s haha."),
                                            insertDivider(),
                                            projectBlurb(
                                                "files/wwf.webp",
                                                "Words With Friends 2 by Zynga (2012)",
                                                "I did some front end work on WWF which was fun because I really do love word games and remember trying new beta features in games with my family back home in Toronto."),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ]),
                                    )),
                              );
                            },
                          );
                        },
                        tooltip: 'some cool stuff i\'ve worked on',
                        shape: const CircleBorder(),
                        backgroundColor: Colors.deepOrangeAccent,
                        foregroundColor: Colors.white,
                        child: const Icon(Icons.work_history_sharp),
                      ),
                      const SizedBox(width: 15),
                      FloatingActionButton(
                        mouseCursor: SystemMouseCursors.basic,
                        onPressed: ()
                        {
                          FirebaseAnalytics.instance.logEvent(name: "showResume");
                          launchUrl(Uri.parse(
                              '${assetPath}KevinFieldingResume2024.pdf'));
                        },
                        tooltip: 'look at my resume',
                        shape: const CircleBorder(),
                        backgroundColor: Colors.deepOrangeAccent,
                        foregroundColor: Colors.white,
                        child: const Icon(Icons.description_sharp),
                      ),
                      const SizedBox(width: 15),
                      FloatingActionButton(
                        mouseCursor: SystemMouseCursors.basic,
                        onPressed: ()
                        {
                          FirebaseAnalytics.instance.logEvent(name: "copyEmail");
                          Clipboard.setData(
                              const ClipboardData(text: 'kvnfldng@gmail.com'))
                              .then((_) =>
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                  content: Text(
                                    'Copied to clipboard: kvnfldng@gmail.com',
                                    textAlign: TextAlign.right,
                                  ))));
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
