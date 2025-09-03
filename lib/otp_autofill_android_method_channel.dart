import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'otp_autofill_android_platform_interface.dart';

/// An implementation of [OtpAutofillAndroidPlatform] that uses method channels.
class MethodChannelOtpAutofillAndroid extends OtpAutofillAndroidPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('otp_autofill_android');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
