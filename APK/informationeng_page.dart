import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dataeng.dart'; // Kumpulan classInfo

class InformationengPage extends StatefulWidget {
  const InformationengPage({super.key});

  @override
  State<InformationengPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationengPage> {
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  String _convertToMarkdown(String raw) {
    return raw.replaceAllMapped(
      RegExp(r'purchase link\s*=\s*"([^"]+)"', caseSensitive: false),
      (match) {
        final link = match[1]!;
        return link.trim().isNotEmpty
            ? '[🔗 Purchase Link]($link)'
            : '_Purchase Link not Found_';
      },
    ).replaceAllMapped(
      RegExp(r'video link\s*=\s*"([^"]+)"', caseSensitive: false),
      (match) {
        final link = match[1]!;
        return link.trim().isNotEmpty
            ? '[▶️ Video Link]($link)'
            : '_Video Link not Found_';
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: classInfo.entries.map((entry) {
        String title = entry.key.replaceAll('_', ' ').toUpperCase();
        return ExpansionTile(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MarkdownBody(
                data: _convertToMarkdown(entry.value),
                onTapLink: (text, href, title) {
                  if (href != null) {
                    _launchUrl(href);
                  }
                },
                selectable: true,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
