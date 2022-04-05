//
//  ComparableExtension.swift
//  FilterTheWorld
//
//  Created by Alexander Katzfey on 4/4/22.
//

import SwiftUI
import Foundation

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
