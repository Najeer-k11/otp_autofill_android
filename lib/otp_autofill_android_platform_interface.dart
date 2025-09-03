import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'otp_autofill_android_method_channel.dart';

abstract class OtpAutofillAndroidPlatform extends PlatformInterface {
  /// Constructs a OtpAutofillAndroidPlatform.
  OtpAutofillAndroidPlatform() : super(token: _token);

  static final Object _token = Object();

  static OtpAutofillAndroidPlatform _instance = MethodChannelOtpAutofillAndroid();

  /// The default instance of [OtpAutofillAndroidPlatform] to use.
  ///
  /// Defaults to [MethodChannelOtpAutofillAndroid].
  static OtpAutofillAndroidPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OtpAutofillAndroidPlatform] when
  /// they register themselves.
  static set instance(OtpAutofillAndroidPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
