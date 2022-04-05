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
                
                ControlView(
                    comicSelected: $model.comicFilter,
                    monoSelected: $model.monoFilter,
                    crystalSelected: $model.crystalFilter,
                    changeCamera: $model.changeCamera,
                    dollyZoomSelected: $model.dollyZoom,
                    zoomFactor: $model.currentZoomFactor,
                    zoomRateMagnitude: $model.zoomRateMagnitude
                )
                                
            }
            .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
