package com.example.tipti_test;

import android.content.Intent;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.os.Handler;

import java.util.Objects;

import io.flutter.Log;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.EventChannel;
import android.hardware.SensorEventListener;

import org.json.JSONObject;

public class MainActivity extends FlutterActivity {

    private SensorActivity sensorActivity;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

    }

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        sensorActivity = new SensorActivity((SensorManager) getSystemService(SENSOR_SERVICE));
        new EventChannel(Objects.requireNonNull(getFlutterEngine()).getDartExecutor(), UTAG.STREAM).setStreamHandler(
                new EventChannel.StreamHandler() {
                    @Override
                    public void onListen(Object args, final EventChannel.EventSink events) {
                        EventSingleTon.getInstance().eventSink = events;
                    }

                    @Override
                    public void onCancel(Object args) {
                        EventSingleTon.getInstance().eventSink = null;
                    }
                });

    }

    @Override
    protected void onResume() {
        super.onResume();
        sensorActivity.onResume();
    }

    @Override
    protected void onPause() {
        super.onPause();
        sensorActivity.onPause();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        EventSingleTon.getInstance().eventSink = null;
    }

}