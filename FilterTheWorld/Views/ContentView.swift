//
//  ContentView.swift
//  FilterTheWorld
//
//  Created by Alexander Katzfey on 4/3/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var model = ContentViewModel()
 
    var body: some View {
        GeometryReader { reader in
            ZStack {
                FrameView(image: model.frame)
                    .edgesIgnoringSafeArea(.all)
                
                ErrorView(error: model.error)
                
                VStack {
                    Text("Z Axis \(model.zAxisMovement)")
                        .padding(.top, 50)
                    Spacer()
                }
                
                VStack(spacing: 0) {
                    Spacer()
                    
                    LabeledSlider(
                        sliderVal: $model.zoomRateMagnitude,
                        sliderLabel: "Dolly Zoom Factor:",
                        format: "%.3f",
                        minSliderVal: 0.001,
                        maxSliderVal: 0.03)
                    
                    LabeledSlider(
                        sliderVal: $model.currentZoomFactor,
                        sliderLabel: "Zoom:",
                        format: "%.2f",
                        minSliderVal: 1.0,
                        maxSliderVal: 5.0)
                    
                    HStack {
                        ToggleButton(selected: $model.dollyZoom, label: "Dolly Zoom")
                            .padding()
                        
                        Button {
                            print("changing camera")
                            model.changeCamera = true
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .resizable()
                                .scaledToFit()
                                .frame(width:35, height: 35)
                        }
                    }
                    
                    HStack(spacing: 12) {
                        ToggleButton(selected: $model.comicFilter, label: "Comic")
                        ToggleButton(selected: $model.monoFilter, label: "Mono")
                        ToggleButton(selected: $model.crystalFilter, label: "Crystal")
                    }
                }
                                
            }
            .preferredColorScheme(.dark)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
