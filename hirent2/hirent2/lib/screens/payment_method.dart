import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});

  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String selectedPaymentMethod = 'QR Code';
  TextEditingController upiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Payment Method'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment method selection
            Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Radio(
                  value: 'QR Code',
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value.toString();
                    });
                  },
                ),
                Text('QR Code'),
                Radio(
                  value: 'UPI ID',
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value.toString();
                    });
                  },
                ),
                Text('UPI ID'),
              ],
            ),
            SizedBox(height: 20),

            // Conditional UI based on payment method selection
            if (selectedPaymentMethod == 'QR Code')
              QRCodePayment()
            else
              UPIIDPayment(upiController: upiController),

            SizedBox(height: 20),

            // Button to initiate payment
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle payment logic here based on the selected method
                  if (selectedPaymentMethod == 'QR Code') {
                    // Handle QR Code payment
                    print('Paying through QR Code...');
                  } else {
                    // Handle UPI ID payment
                    print('Paying through UPI ID...');
                    print('UPI ID: ${upiController.text}');
                  }
                },
                child: Text('Pay Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// QR Code Payment Widget
class QRCodePayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Scan QR Code to pay:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            // Navigate to QR code scanner
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QRScannerPage()),
            );
          },
          child: Text('Scan QR Code'),
        ),
      ],
    );
  }
}

// UPI ID Payment Widget
class UPIIDPayment extends StatelessWidget {
  final TextEditingController upiController;
  UPIIDPayment({required this.upiController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter UPI ID:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        TextField(
          controller: upiController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'UPI ID',
          ),
        ),
      ],
    );
  }
}

// QR Code Scanner Page
class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
      ),
      body: QRView(
        key: qrKey,
        onQRViewCreated: (controller) {
          setState(() {
            this.controller = controller;
          });
          controller.scannedDataStream.listen((scanData) {
            // Handle scanned QR code
            print('Scanned data: ${scanData.code}');
            Navigator.pop(context); // Close QR scanner and go back
          });
        },
      ),
    );
  }
}
