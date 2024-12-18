import 'package:bankingapp/common/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardInputScreen extends StatefulWidget {
  const CardInputScreen({super.key, required this.number, required this.date});

  final String number;
  final String date;

  @override
  _CardInputScreenState createState() => _CardInputScreenState();
}

class _CardInputScreenState extends State<CardInputScreen> {

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();


  String _cardInfo = "Karta ma'lumotlari bu yerda ko'rinadi.";


  void camera() {
    context.push(Routes.camera);
  }

  void nfc() {
    context.push(Routes.nfc);
  }
  @override
  void initState() {
    super.initState();
    _cardNumberController.text = widget.number;
    _expiryDateController.text = widget.date;
  }

  void _saveData() {
    // Foydalanuvchi ma'lumotlarini saqlash logikasi
    debugPrint("Karta raqami: ${_cardNumberController.text}");
    debugPrint("Amal qilish muddati: ${_expiryDateController.text}");
    setState(() {
      _cardInfo = "Karta ma'lumotlari muvaffaqiyatli saqlandi.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Karta Ma'lumotlari"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Karta raqami uchun TextField
            TextField(
              controller: _cardNumberController,
              keyboardType: TextInputType.number,
              maxLength: 16,
              decoration: const InputDecoration(
                labelText: "Karta Raqami",
                hintText: "1234 5678 9012 3456",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Amal qilish muddati uchun TextField
            TextField(
              controller: _expiryDateController,
              keyboardType: TextInputType.datetime,
              maxLength: 5,
              decoration: const InputDecoration(
                labelText: "Amal Qilish Muddati",
                hintText: "MM/YY",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // Uchta Tugma
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: camera,
                  child: Icon(Icons.camera),
                ),
                ElevatedButton(
                  onPressed: nfc,
                  child: Icon(Icons.nfc),
                ),
                ElevatedButton(
                  onPressed: _saveData,
                  child: Icon(Icons.next_plan_outlined),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Natija
            Text(
              _cardInfo,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

