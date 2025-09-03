import 'package:flutter/material.dart';
import 'package:otp_autofill_android/otp_autofill_android.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: OtpPage());
  }
}

class OtpPage extends StatefulWidget {
  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String? otp;

  @override
  void initState() {
    _listenForOtp();
    super.initState();
  }

  void _listenForOtp() async {
    final code = await OtpAutofillAndroid.listenForOtp();
    setState(() => otp = code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("OTP Autofill Plugin")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: TextEditingController(text: otp),
              keyboardType: TextInputType.number,
              autofillHints: const [AutofillHints.oneTimeCode], // iOS
              decoration: const InputDecoration(hintText: "Enter OTP"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _listenForOtp,
              child: const Text("Listen OTP (Android)"),
            ),
            if (otp != null) Text("Received OTP: $otp"),
          ],
        ),
      ),
    );
  }
}
