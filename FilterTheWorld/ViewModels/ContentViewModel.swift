//
//  ContentViewModel.swift
//  FilterTheWorld
//
//  Created by Alexander Katzfey on 4/3/22.
//

import CoreImage
import Foundation

class ContentViewModel: ObservableObject {
    @Published var frame: CGImage?
    @Published var error: Error?
    @Published var zAxisMovement: Double = 0.0
    
    private let frameManager = FrameManager.shared
    private let cameraManager = CameraManager.shared
    private let motionManager = MotionManager()
    
    var comicFilter = false
    var monoFilter = false
    var crystalFilter = false
    var changeCamera = false
    var dollyZoom = false
    var currentZoomFactor = 1.0
    var zoomRateMagnitude = 0.013
    
    private let context = CIContext()
    
    private var cameraFlipped = false
    private var currentZoomSpeed: Double = 0.0
    private let speedDamping: Double = 0.01
    private let maxSpeed: Double = 1.0
    
    init() {
        setupSubscriptions()
    }
    
    func setupSubscriptions() {
        cameraManager.$error
            .receive(on: RunLoop.main)
            .map { $0 }
            .assign(to: &$error)
        
        frameManager.$current
            .receive(on: RunLoop.main)
            .compactMap { $0 }
            .compactMap { buffer in
                guard let image = CGImage.create(from: buffer) else {
                    return nil
                }
                
                var ciImage = CIImage(cgImage: image)
                
                if self.comicFilter {
                    ciImage = ciImage.applyingFilter("CIComicEffect")
                }
                if self.monoFilter {
                    ciImage = ciImage.applyingFilter("CIPhotoEffectNoir")
                }
                if self.crystalFilter {
                    ciImage = ciImage.applyingFilter("CICrystallize")
                }
                
                if self.changeCamera {
                    self.cameraManager.changeCamera()
                    self.changeCamera = false
                    self.cameraFlipped.toggle()
                }
                
                return self.context.createCGImage(ciImage, from: ciImage.extent)
            }
            .assign(to: &$frame)
        
        motionManager.$zAxis
            .receive(on: RunLoop.main)
            .map { axis in
                if self.dollyZoom {
                    self.calcDollyZoom()
                } else if self.cameraManager.videoIsConnected() {
                    self.zoom(with: self.currentZoomFactor)
                    self.currentZoomSpeed = 0.0
                }
                
                return axis
            }
            .assign(to: &$zAxisMovement)
    }
    
    func calcDollyZoom() {
        if abs(motionManager.zAxis) > 0.2 {
            currentZoomSpeed += motionManager.zAxis * zoomRateMagnitude
        } else {
            if abs(currentZoomSpeed) > 0.004 {
                currentZoomSpeed += (currentZoomSpeed > 0 ? -speedDamping : speedDamping)
            } else {
                currentZoomSpeed = 0
            }
        }
        print(currentZoomSpeed)
        currentZoomSpeed = currentZoomSpeed.clamped(to: -maxSpeed...maxSpeed)
        currentZoomFactor += cameraFlipped ? -currentZoomSpeed : currentZoomSpeed//CGFloat(smooth(0.5, currentZoomSpeed, Double(currentZoomFactor)))
        currentZoomFactor = currentZoomFactor.clamped(to: 1.0...5.0)
        self.zoom(with: self.currentZoomFactor)
    }
    
    func smooth(_ a: Double, _ t: Double, _ s: Double) -> Double {
        let aClamp = a.clamped(to: 0.0...1.0)
        return (aClamp * t) + (1.0 - aClamp) * s
    }
    
    func zoom(with factor: CGFloat) {
        CameraManager.shared.set(zoom: factor)
    }
}
