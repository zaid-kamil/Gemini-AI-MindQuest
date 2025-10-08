import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  /// Opens a URL in a new browser tab
  static Future<bool> openInNewTab(String urlString) async {
    try {
      final url = Uri.parse(urlString);
      return await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      );
    } catch (e) {
      print('Error launching URL: $e');
      return false;
    }
  }

  /// Opens multiple URLs with a delay between each
  static Future<void> openMultipleUrls(List<String> urls, {int delayMs = 500}) async {
    for (var i = 0; i < urls.length; i++) {
      await Future.delayed(Duration(milliseconds: i * delayMs));
      await openInNewTab(urls[i]);
    }
  }
}
