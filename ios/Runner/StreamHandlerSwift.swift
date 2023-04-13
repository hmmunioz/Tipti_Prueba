//
//  NotificationPlugin.swift
//  Runner
//
//  Created by Saul Mestanza on 14/1/21.
//

import Foundation
import Flutter


 class StreamHandlerSwift:NSObject,  FlutterStreamHandler {
    
   
    private var eventSink: FlutterEventSink?
    private var argument = ""
    private var sensorsHandler = SensorsHandler()
    
     @objc func startReadGyroData(){
      sensorsHandler.startGyros(eventSink: self.eventSink)
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        startReadGyroData()
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        if let arguments = arguments {
            print("StreamHandler - onCancel: \(arguments)")
        }
        return nil
    }
}
                                                                                                                                                                  


