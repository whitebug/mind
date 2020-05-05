package com.sodnomov.mind;

import android.app.Activity;
import android.content.Context;
import android.media.AudioManager;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class MainActivity implements FlutterPlugin, ActivityAware, MethodCallHandler {

  private MethodChannel channel;
  private Activity activity;
  private AudioManager audioManager;
  private int streamType;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    channel = new MethodChannel(
            binding.getBinaryMessenger(), "volume");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    channel = null;
  }

  @Override
  public void onAttachedToActivity(ActivityPluginBinding binding) {
    activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivity() {
    activity = null;
  }

  @Override
  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {
    activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    activity = null;
  }

  @Override
  public void onMethodCall(MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case "controlVolume": {
        int i = call.argument("streamType");
        streamType = i;
        controlVolume(i);
        result.success(null);
        break;
      }
      case "getMaxVol":
        result.success(getMaxVol());
        break;
      case "getVol":
        result.success(getVol());
        break;
      case "setVol": {
        int i = call.argument("newVol");
        int showUiFlag = call.argument("showVolumeUiFlag");
        setVol(i, showUiFlag);
        result.success(0);
        break;
      }
      default:
        result.notImplemented();
        break;
    }
  }

  private void controlVolume(int i) {
    this.activity.setVolumeControlStream(i);
  }

  private void initAudioManager() {
    audioManager = (AudioManager) this.activity.getApplicationContext().getSystemService(Context.AUDIO_SERVICE);
  }

  private int getMaxVol() {
    initAudioManager();
    return audioManager.getStreamMaxVolume(streamType);
  }

  private int getVol() {
    initAudioManager();
    return audioManager.getStreamVolume(streamType);
  }

  private int setVol(int i, int showVolumeUiFlag) {
    initAudioManager();
    audioManager.setStreamVolume(streamType, i, showVolumeUiFlag);
    return audioManager.getStreamVolume(streamType);
  }
}