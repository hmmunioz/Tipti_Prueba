package com.example.tipti_test;

import android.app.Activity;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;

import org.json.JSONException;
import org.json.JSONObject;

public class SensorActivity  implements SensorEventListener {
    private final SensorManager mSensorManager;
    private final Sensor mGyroscope;
    public SensorActivity(SensorManager sm) {
        mSensorManager = sm;
        mGyroscope = mSensorManager.getDefaultSensor(Sensor.TYPE_GYROSCOPE);
    }

    protected void onResume() {
        mSensorManager.registerListener(this, mGyroscope, SensorManager.SENSOR_DELAY_UI);
    }

    protected void onPause() {
        mSensorManager.unregisterListener(this);
    }

    @Override
    public void onSensorChanged(SensorEvent sensorEvent) {
        JSONObject sensorModelJson = new JSONObject();
        try {
            sensorModelJson.put("x", sensorEvent.values[0]);
            sensorModelJson.put("y", sensorEvent.values[1]);
            sensorModelJson.put("z", sensorEvent.values[2]);
            sendValueToChannel(sensorModelJson);
        } catch (JSONException e) {
            e.printStackTrace();
        }

    }

    private void sendValueToChannel(JSONObject modelJson) {

        if (EventSingleTon.getInstance().eventSink != null) {
            EventSingleTon.getInstance().eventSink.success(modelJson.toString());
        }

    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int accuracy) {

    }
}