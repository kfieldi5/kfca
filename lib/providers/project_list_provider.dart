import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kfca/models/project.dart';

final List<Project> _projects = [
  const Project(
    imagePath: "files/skims.webp",
    title: "Skims (2025-2026)",
    desc:
        "Stepping into an Engineering Manager role at a large corporate glob was not on my 2025 bingo card, but after meeting with the team I decided it would be a fun new effort and I had never worked in B2C e-comm before. Despite leading a great team, the company's traditional clothing-retail-corporate structure made it a bit difficult to get things done. Grateful for the opportunity though.",
  ),
  const Project(
    imagePath: "files/rabbit.webp",
    title: "Rabbit R1 (2024-2025)",
    desc:
        "Joined the team after hearing about it at CES 2024. I love the synths Teenage Engineering makes and the fact that they were involved in the hardware design for this pocket AI device made me very interested. We are still pumping out feature after feature with 50 balls in the air but the device has taken massive strides. We are now experimenting with Generative UI, as well as different avenues for agentic AI. I am leading up the computer vision recognition project which we are currently testing on Android, at the user operating level, allowing us to really do things never done before with Siri or Google Assistant. ",
    linkText: "Checkout the video I made outlining this work on The Verge.",
    link:
        "https://www.theverge.com/news/615990/rabbit-ai-agent-demonstration-lam-android-r1",
  ),
  const Project(
    imagePath: "files/soap.webp",
    title: "SOAP Audio (2023)",
    desc:
        "I started making some audio manipulation plugins with a couple pals to increase our workflow when editing hobbyist podcasts and tutorial videos. We only have a single plugin available for download right now.",
  ),
  const Project(
    imagePath: "files/lumos1.webp",
    title: "Lumosity (2017-2023)",
    desc:
        "I had the pleasure of working on this beast of an app on and off for 6 years and helped transition it to its latest form: a Flutter iOS/Android app. For the time being, I think the company is keeping the web experience in JS. The mobile app has had 3 different types of game engines embedded, three major redesign overhauls and loads of features over the nearly 2 decades it's been around. Working closely with the neuroscience team and understanding the 'why' behind the games was definitely a big highlight.",
  ),
  const Project(
    imagePath: "files/mind.webp",
    title: "Lumosity Mind (2021)",
    desc:
        "This was the Lumos Labs venture into the meditation app market and we learned a ton from it. Product lessons aside, the engineering core created its first cross platform UI-kit and services bundle that handled creating a uniform Login and Settings experience across our mobile apps. Eventually this app was converted to Flutter too.",
  ),
  const Project(
    imagePath: "files/figment.webp",
    title: "Figment by Lumosity (2020)",
    desc:
        "An app that challenged the way creativity was sparked and used routine and a large variety or prompts to keep users engaged and having fun! First app to use our cross platform bundles from Mind.",
  ),
  const Project(
    imagePath: "files/pono.webp",
    title: "PonoMusic & PonoPlayer (2014-2017)",
    desc:
        "Getting to not only work with one of my biggest musical heroes but also having to advise against his will was a surreal experience I look back on fondly. Neil Young is a tough cookie but he was an understanding CEO if presented the information well. Despite the product not having much of a shelf life we still like to think we played somewhat of a role in Tidal, Apple Music and Spotify all upping the quality of their streamed content.",
  ),
  const Project(
    imagePath: "files/poker.webp",
    title: "Zynga Poker (2011-2014)",
    desc:
        "I'm so proud that this product has withstood the test of time. We innovated so much on such a basic game and everyone on the team wore all the hats. The biggest highlight was probably leading the 'Multi-Table Tournament' project which allowed players to play in massive online tournaments with real world prizes. Server jumping, cross-server chat, economy syncing - so much cool stuff.",
  ),
  const Project(
    imagePath: "files/farmville2.webp",
    title: "Farmville 2 by Zynga (2013)",
    desc:
        "We worked so hard and played even harder on this team lol. When I think back to the Vegas trips or other very 2010s-Silicon-Valley type stuff we did (after pulling days, sometimes weeks, of all nighters) I'm just glad I did it when I was in my early 20s haha.",
  ),
  const Project(
    imagePath: "files/wwf.webp",
    title: "Words With Friends 2 by Zynga (2012)",
    desc:
        "I did some front end work on WWF which was fun because I really do love word games and remember trying new beta features in games with my family back home in Toronto.",
  ),
];

final projectListProvider = Provider((ref) => _projects);
