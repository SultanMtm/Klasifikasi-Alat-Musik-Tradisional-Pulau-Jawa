import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'data.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class PredictionPage extends StatefulWidget {
  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  File? _image;
  String _result = '';
  String _desc = '';

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: "assets/modelalatmusikmobnetv2lastwop.tflite",
      labels: "assets/labels.txt",
    );
  }

  Future<void> predictImage(File image) async {
    final bytes = await image.readAsBytes();
    final img.Image? oriImage = img.decodeImage(bytes);

    if (oriImage == null) {
      setState(() {
        _result = "Gagal membaca gambar";
        _desc = '';
      });
      return;
    }

    // Resize ke 224x224 dan normalisasi
    final img.Image resizedImage =
        img.copyResize(oriImage, width: 224, height: 224);
    final Uint8List input = imageToByteListFloat32(resizedImage, 224);

    // Prediksi
    final recognitions = await Tflite.runModelOnBinary(
      binary: input,
      numResults: 1,
      threshold: 0.5,
    );

    if (recognitions != null && recognitions.isNotEmpty) {
      String label = recognitions.first['label'];
      double confidence = recognitions.first['confidence'] ?? 0.0;

      if (confidence >= 0.9) {
        setState(() {
          _result = label;
          _desc = classInfo[label] ?? "Deskripsi tidak ditemukan";
        });
      } else {
        setState(() {
          _result = "Bukan Alat Musik Tradisional Pulau Jawa";
          _desc = '';
        });
      }
    }
  }

  Uint8List imageToByteListFloat32(img.Image image, int inputSize) {
    final Float32List floatList = Float32List(inputSize * inputSize * 3);
    int index = 0;

    for (int y = 0; y < inputSize; y++) {
      for (int x = 0; x < inputSize; x++) {
        final pixel = image.getPixel(x, y); // PixelRGBA atau sejenis
        floatList[index++] = pixel.r / 255.0;
        floatList[index++] = pixel.g / 255.0;
        floatList[index++] = pixel.b / 255.0;
      }
    }

    return floatList.buffer.asUint8List();
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      setState(() => _image = imageFile);
      await predictImage(imageFile);
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

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        ElevatedButton.icon(
          icon: Icon(Icons.camera),
          label: Text("Ambil dari Kamera"),
          onPressed: () => pickImage(ImageSource.camera),
        ),
        ElevatedButton.icon(
          icon: Icon(Icons.upload),
          label: Text("Unggah dari Galeri"),
          onPressed: () => pickImage(ImageSource.gallery),
        ),
        SizedBox(height: 20),
        if (_image != null) ...[
          Image.file(_image!),
          SizedBox(height: 10),
          Text("🎼 Prediksi: $_result", style: TextStyle(fontSize: 18)),
          Divider(),
          MarkdownBody(
            data: _convertToMarkdown(_desc),
            selectable: true,
            onTapLink: (text, href, title) {
              if (href != null) {
                _launchUrl(href);
              }
            },
          ),
        ],
      ],
    );
  }
}
