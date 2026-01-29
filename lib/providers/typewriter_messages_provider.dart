import 'package:flutter_riverpod/flutter_riverpod.dart';

final List<String> _messages = [
  "welcome to my isle!",
  "this is a flutter app.",
  "written in dart, kotlin, swift and js.",
  "(still under construction)",
  "it is hosted and unit tested via Firebase,",
  "but is also runnable as an Android or iOS app",
  "...some stuff about me...",
  "i am a massive nba fan...",
  "and a novice motorcycle mechanic",
  "i've been a full stack eng since 2012",
  "i weirdly enjoy CI/CD config",
  "drop me a line..."
];

final typewriterMessagesProvider = Provider((ref) => _messages);
