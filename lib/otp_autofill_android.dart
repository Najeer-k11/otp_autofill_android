
import 'package:flutter/services.dart';
import 'otp_autofill_android_platform_interface.dart';

class OtpAutofillAndroid {
  static const MethodChannel _channel = MethodChannel('otp_autofill_android');

  /// Start listening for OTP on Android
  static Future<String?> listenForOtp() async {
    final otp = await _channel.invokeMethod<String>('startListening');
    return otp;
  }
  Future<String?> getPlatformVersion() {
    return OtpAutofillAndroidPlatform.instance.getPlatformVersion();
  }
}
