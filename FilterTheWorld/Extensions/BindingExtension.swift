//
//  BindingExtension.swift
//  FilterTheWorld
//
//  Created by Alexander Katzfey on 4/4/22.
//

import SwiftUI
import Foundation

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}
