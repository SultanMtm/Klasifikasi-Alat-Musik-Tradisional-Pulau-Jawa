import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'data.dart'; // Kumpulan classInfo

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  String _convertToMarkdown(String raw) {
    return raw.replaceAllMapped(
      RegExp(r'link pembelian\s*=\s*"([^"]+)"', caseSensitive: false),
      (match) {
        final link = match[1]!;
        return link.trim().isNotEmpty
            ? '[🔗 Link Pembelian]($link)'
            : '_Link pembelian tidak tersedia_';
      },
    ).replaceAllMapped(
      RegExp(r'link video\s*=\s*"([^"]+)"', caseSensitive: false),
      (match) {
        final link = match[1]!;
        return link.trim().isNotEmpty
            ? '[▶️ Link Video]($link)'
            : '_Link video tidak tersedia_';
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
