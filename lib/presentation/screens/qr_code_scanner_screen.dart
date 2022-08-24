import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:la_vie/business_logic/la_vie_cubit/cubit.dart';
import 'package:la_vie/constants/styles.dart';
import 'package:la_vie/presentation/screens/layout_screen.dart';
import 'package:la_vie/presentation/widgets/widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({Key? key}) : super(key: key);

  @override
  _QrCodeScreenState createState() => _QrCodeScreenState();
}
class _QrCodeScreenState extends State<QrCodeScreen> {

   GlobalKey qrKey = GlobalKey(debugLabel: 'QR key');
   Barcode? result;
   QRViewController? qrViewController;

   @override
   void reassemble() {
    super.reassemble();
    if(Platform.isAndroid){
      qrViewController?.pauseCamera();
    }else if(Platform.isIOS){
      qrViewController?.resumeCamera();
    }
  }

   @override
  void dispose() {
    qrViewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryHeight = MediaQuery.of(context).size.height;
    var mediaQueryWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      width: mediaQueryWidth,
                      height: mediaQueryHeight-24,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          buildQrView(context),
                          Positioned(
                            bottom: 500,
                            right: 300,
                            child: GestureDetector(
                              onTap: (){
                                navigateTo(context, LayoutScreen());
                                LaVieCubit.get(context).currentIndex = 2;
                              },
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.green,
                                child: Center(child: Icon(Icons.arrow_back, color: Colors.white,)),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 55,
                            child: /*result!= null ?*/GestureDetector(
                              onTap:(){
                                showBottomSheet(context: (context), builder: (context){
                                  return Column( crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    Text('Plant name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
                                  ],);
                                });
                              },
                              child: Container(
                                width: 300,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Plant Name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                      Text('Source'),
                                    ],
                                  ),
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.green,
                                    ),
                                    child: Icon(Icons.arrow_forward, color: Colors.white,),
                                  )
                                ],),

                              ),
                            ) /*: Text('')*/,
                          )
                        ],),
                    ),
                  ),
                ],
              ),
            ],)
      ),
    );
  }

  Widget buildQrView(context)=> QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
    overlay: QrScannerOverlayShape(
      cutOutSize: MediaQuery.of(context).size.width *0.8,
      borderColor: Colors.white,
      borderRadius: 5,
      borderLength: 80,
      borderWidth: 10,
    ),
  );

  void onQRViewCreated(QRViewController controller) {
     setState(()=> qrViewController = controller);
     controller.scannedDataStream.listen((scanData) {
       setState(() {
         result= scanData;
       });
     });
  }
}
/*


result != null?
Text('Barcode Type: ${describeEnum(result!.format)} Data: ${result!.code}') :
Text('Scan code'),*/
