import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class OCRScreen extends StatelessWidget {
  final String imagePath;

  OCRScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OCR Natijasi')),
      body: FutureBuilder<Map<String, String>>(
        future: _recognizeText(imagePath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Karta Raqami: ${data["cardNumber"]}",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Amal Qilish Muddat: ${data["expiryDate"]}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text("Hech qanday ma'lumot topilmadi."));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
  Future<Map<String, String>> _recognizeText(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognizedText =
    await textRecognizer.processImage(inputImage);
    textRecognizer.close();

    String detectedCardNumber = "";
    String detectedExpiryDate = "";

    // Karta raqamini va amal qilish muddatini qidiramiz
    final RegExp cardNumberPattern =
    RegExp(r'\b(?:\d{4}[ -]?){3}\d{4}\b');
    final RegExp cardExpiryPattern =
    RegExp(r'(0[1-9]|1[0-2])\/?([0-9]{2})');

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        // Karta raqamini topamiz
        if (cardNumberPattern.hasMatch(line.text)) {
          detectedCardNumber = line.text.replaceAll(RegExp(r'[^\d]'), ''); // Bo‘sh joylarni olib tashlash
        }
        // Amal qilish muddatini topamiz
        if (cardExpiryPattern.hasMatch(line.text)) {
          detectedExpiryDate = cardExpiryPattern.stringMatch(line.text) ?? "";
        }
      }
    }

    return {
      "cardNumber": detectedCardNumber.isNotEmpty
          ? detectedCardNumber
          : "Karta raqami topilmadi.",
      "expiryDate": detectedExpiryDate.isNotEmpty
          ? detectedExpiryDate
          : "Amal qilish muddati topilmadi."
    };
  }

}
