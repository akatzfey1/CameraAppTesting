//
//  LabeledSlider.swift
//  FilterTheWorld
//
//  Created by Alexander Katzfey on 4/6/22.
//

import SwiftUI

struct LabeledSlider: View {
    
    @Binding var sliderVal: Double
    var sliderLabel: String
    var format: String
    var minSliderVal: Double
    var maxSliderVal: Double
    
    var body: some View {
        VStack {
            Text("\(sliderLabel) \(String(format: format, sliderVal))")
                .padding(0)
            Slider(value: $sliderVal, in: minSliderVal...maxSliderVal) {
                Text(sliderLabel)
            } minimumValueLabel: {
                Text("\(String(format: format, minSliderVal))")
            } maximumValueLabel: {
                Text("\(String(format: format, maxSliderVal))")
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 0)
        }
    }
}

struct LabeledSlider_Previews: PreviewProvider {
    static var previews: some View {
        LabeledSlider(
            sliderVal: .constant(0.1),
            sliderLabel: "Zoom:",
            format: "%.3f",
            minSliderVal: 0.01,
            maxSliderVal: 0.2)
        .preferredColorScheme(.dark)
    }
}
