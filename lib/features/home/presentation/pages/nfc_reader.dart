import 'package:bankingapp/common/app_color.dart';
import 'package:bankingapp/common/app_routes.dart';
import 'package:bankingapp/common/app_style.dart';
import 'package:bankingapp/common/assets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nfc_manager/nfc_manager.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _startNFCReading();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(Assets.images.imgNfc),fit: BoxFit.cover)
            ),
            child: Positioned(
              top: 100,
              child: Text("Iltimos kartangizni telefonga yaqinroq olib keling.",style: AppStyle.medium(size: 25,color: AppColor.clPrDark010513),textAlign: TextAlign.center,),
            ),
        ),
      ),
    );
  }

  void _startNFCReading() async {
    try {
      bool isAvailable = await NfcManager.instance.isAvailable();

      //We first check if NFC is available on the device.
      if (isAvailable) {
        //If NFC is available, start an NFC session and listen for NFC tags to be discovered.
        NfcManager.instance.startSession(
          onDiscovered: (NfcTag tag) async {
            context.push(Routes.home,extra: {
              "number":"",
              "date":""
            });
            // Process NFC tag, When an NFC tag is discovered, print its data to the console.
            debugPrint('NFC Tag Detected: ${tag.data}');
          },
        );
      } else {
        debugPrint('NFC not available.');
      }
    } catch (e) {
      debugPrint('Error reading NFC: $e');
    }
  }
}