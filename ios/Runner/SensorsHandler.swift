//
//  PulseraHandler.swift
//  Runner
//
//  Created by Saul Mestanza on 22/2/21.
//
import Foundation
import UIKit
import CoreMotion

class SensorsHandler {
    let motion = CMMotionManager()
    var timer : Timer?
    var GyroVar = 0
    var gyroData: CMGyroData?

    func startGyros(eventSink events: FlutterEventSink?) {
      if motion.isGyroAvailable {
       self.motion.gyroUpdateInterval = 2.0 / 60.0
          self.motion.startGyroUpdates()
            if #available(iOS 10.0, *) {
               self.timer = Timer(fire: Date(), interval: (2.0/60.0),
                              repeats: true, block: { (timer) in
                  if let data = self.motion.gyroData {
                  let sensorModelJson: [String: Double] = [
                    "x": data.rotationRate.x,
                    "y": data.rotationRate.y,
                    "z":data.rotationRate.z
                   ]
                      
                   if events != nil {
                       events!(self.stringify(json:sensorModelJson))
                   }
               }
           })
       }
      RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
   }

  }

   func stringify(json: Any, prettyPrinted: Bool = false) -> String {
        var options: JSONSerialization.WritingOptions = []
        if prettyPrinted {
          options = JSONSerialization.WritingOptions.prettyPrinted
        }
        do {
          let data = try JSONSerialization.data(withJSONObject: json, options: options)
          if let string = String(data: data, encoding: String.Encoding.utf8) {
            return string
          }
        } catch {
          print(error)
        }

        return ""
    }

func stopGyros() {
   if self.timer != nil {
      self.timer?.invalidate()
      self.timer = nil

      self.motion.stopGyroUpdates()
   }
}
      
}
