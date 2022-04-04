//
//  MotionManager.swift
//  FilterTheWorld
//
//  Created by Alexander Katzfey on 4/3/22.
//

import Foundation
import SwiftUI
import CoreMotion

class MotionManager: ObservableObject {
    
    @Published var zAxis: Double = 0.0
    
    private let magnitude = 10.0
    
    private var manager: CMMotionManager
    
    init() {
        self.manager = CMMotionManager()
        self.manager.deviceMotionUpdateInterval = 1/60
        self.manager.startDeviceMotionUpdates(to: .main) { (motionData, error) in
            guard error == nil else {
                print(error!)
                return
            }
            
            if let motionData = motionData {
                self.zAxis = motionData.userAcceleration.z * self.magnitude
                //print(self.zAxis)
            }
        }
    }
    
}
