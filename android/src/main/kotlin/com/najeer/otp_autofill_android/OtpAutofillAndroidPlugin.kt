package com.najeer.otp_autofill_android

import android.app.Activity
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import java.util.regex.Pattern
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/** OtpAutofillAndroidPlugin */
class OtpAutofillAndroidPlugin : FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private var otpReceiver: BroadcastReceiver? = null

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "otp_autofill")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        if (call.method == "startListening") {
            startSmsListener(result)
        } else {
            result.notImplemented()
        }
    }

    private fun startSmsListener(result: MethodChannel.Result) {
        val filter = IntentFilter("android.provider.Telephony.SMS_RECEIVED")

        otpReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent?) {
                val bundle: Bundle? = intent?.extras
                if (bundle != null) {
                    val pdus = bundle["pdus"] as Array<*>
                    for (pdu in pdus) {
                        val format = bundle.getString("format")
                        val sms = android.telephony.SmsMessage.createFromPdu(pdu as ByteArray, format)
                        val messageBody = sms.messageBody
                        val matcher = Pattern.compile("\\d{4,6}").matcher(messageBody)
                        if (matcher.find()) {
                            result.success(matcher.group(0))
                            activity?.unregisterReceiver(this)
                            return
                        }
                    }
                }
            }
        }
        activity?.registerReceiver(otpReceiver, filter)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }
}
