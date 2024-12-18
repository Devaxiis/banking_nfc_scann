import 'package:bankingapp/common/app_color.dart';
import 'package:bankingapp/common/app_routes.dart';
import 'package:bankingapp/common/app_style.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _cameraController!.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Karta Skaneri')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                // Kamera oldindan ko'rinishi
                CameraPreview(_cameraController!),
                _buildOverlay(), // Overlay (to'rtburchak xudud)
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () async {
          try {
            await _initializeControllerFuture;

            // Rasmga olish
            final image = await _cameraController!.takePicture();

            // OCR natijalarini ko'rish
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OCRScreen(imagePath: image.path),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }

  Widget _buildOverlay() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        final rectWidth = width * 0.8;
        final rectHeight = height * 0.3;
        final rectLeft = (width - rectWidth) / 2;
        final rectTop = (height - rectHeight) / 2;

        return Stack(
          children: [
            CustomPaint(
              size: Size(width, height),
              painter: OverlayPainter(
                rect: Rect.fromLTWH(rectLeft, rectTop, rectWidth, rectHeight),
              ),
            ),
            Positioned(
              left: rectLeft,
              top: rectTop,
              child: Container(
                width: rectWidth,
                height: rectHeight,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 2),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class OverlayPainter extends CustomPainter {
  final Rect rect;

  OverlayPainter({required this.rect});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    final outer = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final inner = Path()..addRect(rect);
    final path = Path.combine(PathOperation.difference, outer, inner);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class OCRScreen extends StatelessWidget {
  final String imagePath;

  OCRScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.clPrBackgroundf5f7f9,
      appBar: AppBar(title: Text('Karta Malumtlari')),
      body: FutureBuilder<Map<String, String>>(
        future: _recognizeText(imagePath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 15,
                    children: [
                      Spacer(),
                      Text(
                        "Karta Raqami: ${data["cardNumber"]}",
                        style: AppStyle.medium(size: 20,color: AppColor.clPrDark010513),
                      ),

                      Text(
                        "Amal Qilish Muddat: ${data["expiryDate"]}",
                        style: AppStyle.medium(size: 15,color: AppColor.clPrDark010513),
                      ),
                     SizedBox(height: 20,),
                     Center(child: Text("Karta malumotlar to'g'rimi",style: AppStyle.regular(size: 15,color: AppColor.clPrDark010513),)),
                     Spacer(),
                     InkWell(
                       onTap: (){
                         int? number = 0;
                         int? date = 0;
                          number = int.tryParse("${data["cardNumber"]}") ;
                         List? a = data["expiryDate"]!.split("/");
                          date = int.tryParse(a.toString());
                         if(number != 0 && date != 0){
                         context.pushReplacement(Routes.home,extra: {
                           "number": data["cardNumber"],
                           "date": data["expiryDate"]
                         });
                         }else{
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Malumotlarni to'liq emas",style: AppStyle.regular(size: 14,color: AppColor.clPrWhiteFFFFFF
                           ),)));
                         }
                       },
                       child: Container(
                         height: 50.sp,
                         width: MediaQuery.sizeOf(context).width,
                         alignment: Alignment.center,
                         decoration: BoxDecoration(
                           color: AppColor.clGreen30bf77,
                           borderRadius: BorderRadius.circular(12)
                         ),
                         child: Text("Foydalanish",style: AppStyle.medium(size: 20),),
                       ),
                     ),
                      InkWell(
                        onTap: (){
                          context.push(Routes.camera);
                        },
                        child: Container(
                          height: 50.sp,
                          width: MediaQuery.sizeOf(context).width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColor.clPrRedF443376,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Text("Qayta scanerlash",style: AppStyle.medium(size: 20),),
                        ),
                      ),
                    SizedBox(
                      height: 100,
                    ),
                    ],
                  ),
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

    // Karta raqami va amal qilish muddatini topish
    final RegExp cardNumberPattern = RegExp(r'\b(?:\d{4}[ -]?){3}\d{4}\b');
    final RegExp cardExpiryPattern = RegExp(r'(0[1-9]|1[0-2])\/?([0-9]{2})');

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        if (cardNumberPattern.hasMatch(line.text)) {
          detectedCardNumber =
              line.text.replaceAll(RegExp(r'[^\d]'), ''); // Faqat raqamlar
        }
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



// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
//
// import 'ocp_page.dart';
//
// class CameraScreen extends StatefulWidget {
//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }
//
// class _CameraScreenState extends State<CameraScreen> {
//   CameraController? _cameraController;
//   Future<void>? _initializeControllerFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }
//
//   void _initializeCamera() async {
//     final cameras = await availableCameras();
//     final firstCamera = cameras.first;
//
//     _cameraController = CameraController(
//       firstCamera,
//       ResolutionPreset.high,
//     );
//     _initializeControllerFuture = _cameraController!.initialize();
//     setState(() {});
//   }
//
//   @override
//   void dispose() {
//     _cameraController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Kamera orqali karta skaneri')),
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return CameraPreview(_cameraController!);
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.camera),
//         onPressed: () async {
//           try {
//             await _initializeControllerFuture;
//             final image = await _cameraController!.takePicture();
//             Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => OCRScreen(imagePath: image.path),
//             ));
//           } catch (e) {
//             print(e);
//           }
//         },
//       ),
//     );
//   }
// }
