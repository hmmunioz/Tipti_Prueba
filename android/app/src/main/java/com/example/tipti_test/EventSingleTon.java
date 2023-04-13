package com.example.tipti_test;

import io.flutter.plugin.common.EventChannel;

public class EventSingleTon {
    private static EventSingleTon mInstance = null;

    public EventChannel.EventSink eventSink;
    public Object o;

    protected EventSingleTon() {
    }

    public static synchronized EventSingleTon getInstance() {
        if (null == mInstance) {
            mInstance = new EventSingleTon();
        }
        return mInstance;
    }
}