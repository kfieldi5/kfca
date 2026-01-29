import 'dart:html' as html;

class PlatformInfo {
  static bool get isMobileWeb {
    final ua = html.window.navigator.userAgent;
    return ua.contains('Mobi') ||
        ua.contains('Android') ||
        ua.contains('iPhone') ||
        ua.contains('iPad') ||
        ua.contains('iPod');
  }

  static bool get isIosSafari {
    final ua = html.window.navigator.userAgent;
    final isIOS = RegExp(r'iP(hone|od|ad)').hasMatch(ua);
    final isSafari = ua.contains('Safari') &&
        !ua.contains('CriOS') &&
        !ua.contains('FxiOS') &&
        !ua.contains('EdgiOS');
    return isIOS && isSafari;
  }
}
