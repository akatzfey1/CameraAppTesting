/// Copyright (c) 2021 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct ControlView: View {
    @Binding var comicSelected: Bool
    @Binding var monoSelected: Bool
    @Binding var crystalSelected: Bool
    @Binding var dollyZoomSelected: Bool
    @Binding var zoomFactor: Double
    @Binding var zoomRateMagnitude: Double
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Text("Dolly Zoom Factor: \(String(format: "%.3f", zoomRateMagnitude))")
                .padding(0)
            Slider(value: $zoomRateMagnitude, in: 0.001...0.03) {
                Text("Zoom")
            } minimumValueLabel: {
                Text("0.001")
            } maximumValueLabel: {
                Text("0.03")
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 0)
            
            Text("Zoom:")
                .padding(0)
            Slider(value: $zoomFactor, in: 1.0...5.0) {
                Text("Zoom")
            } minimumValueLabel: {
                Text("1.0")
            } maximumValueLabel: {
                Text("5.0")
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 0)
            
            ToggleButton(selected: $dollyZoomSelected, label: "Dolly Zoom")
                .padding()
            
            HStack(spacing: 12) {
                ToggleButton(selected: $comicSelected, label: "Comic")
                ToggleButton(selected: $monoSelected, label: "Mono")
                ToggleButton(selected: $crystalSelected, label: "Crystal")
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct ControlView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            ControlView(
                comicSelected: .constant(false),
                monoSelected: .constant(true),
                crystalSelected: .constant(true),
                dollyZoomSelected: .constant(false),
                zoomFactor: .constant(1.0),
                zoomRateMagnitude: .constant(0.013))
        }
    }
}
