//
//  ContentView.swift
//  FilterTheWorld
//
//  Created by Alexander Katzfey on 4/3/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var model = ContentViewModel()
    @StateObject private var motion = MotionManager()
    
    @State var currentZoomFactor: CGFloat = 1.0
    
    @State private var isLongPressing = false
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                FrameView(image: model.frame)
                    .edgesIgnoringSafeArea(.all)
                    .gesture(
                        DragGesture().onChanged({ (val) in
                            //  Only accept vertical drag
                            if abs(val.translation.height) > abs(val.translation.width) {
                                //  Get the percentage of vertical screen space covered by drag
                                let percentage: CGFloat = -(val.translation.height / reader.size.height)
                                //  Calculate new zoom factor
                                let calc = currentZoomFactor + percentage
                                //  Limit zoom factor to a maximum of 5x and a minimum of 1x
                                let zoomFactor: CGFloat = min(max(calc, 1), 5)
                                //  Store the newly calculated zoom factor
                                currentZoomFactor = zoomFactor
                                //  Sets the zoom factor to the capture device session
                                model.zoom(with: zoomFactor)
                            }
                        })
                    )
                ErrorView(error: model.error)
                ControlView(
                    comicSelected: $model.comicFilter,
                    monoSelected: $model.monoFilter,
                    crystalSelected: $model.crystalFilter)
                
                VStack {
                    
                    Spacer()
                    
                    Color(.red)
                    .frame(width: 50, height: 50)
                    .simultaneousGesture(LongPressGesture(minimumDuration: 0.2).onEnded({ Bool in
                        print("Long press")
                        isLongPressing = true
                    }))
                    .padding(75)
                }
                
            }
            .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        //.preferredColorScheme(.dark)
    }
}
