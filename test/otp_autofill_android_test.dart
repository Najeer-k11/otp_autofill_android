import 'package:flutter_test/flutter_test.dart';
import 'package:otp_autofill_android/otp_autofill_android.dart';
import 'package:otp_autofill_android/otp_autofill_android_platform_interface.dart';
import 'package:otp_autofill_android/otp_autofill_android_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockOtpAutofillAndroidPlatform
    with MockPlatformInterfaceMixin
    implements OtpAutofillAndroidPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final OtpAutofillAndroidPlatform initialPlatform = OtpAutofillAndroidPlatform.instance;

  test('$MethodChannelOtpAutofillAndroid is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelOtpAutofillAndroid>());
  });

  test('getPlatformVersion', () async {
    OtpAutofillAndroid otpAutofillAndroidPlugin = OtpAutofillAndroid();
    MockOtpAutofillAndroidPlatform fakePlatform = MockOtpAutofillAndroidPlatform();
    OtpAutofillAndroidPlatform.instance = fakePlatform;

    expect(await otpAutofillAndroidPlugin.getPlatformVersion(), '42');
  });
}
