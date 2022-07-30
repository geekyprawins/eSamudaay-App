import 'package:url_launcher/url_launcher.dart';

class OpenLinks {
  static _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      print('Cant open url');
      throw 'Cant launch $url ffs';
    }
  }

  static Future openEmail({
    required String toEmail,
    required String subject,
    required String body,
  }) async {
    final url =
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}';

    await _launchUrl(url);
  }

  static Future openLink({
    required String url,
  }) =>
      _launchUrl(url);
}
