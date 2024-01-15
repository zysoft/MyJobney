//
//  TestBinding.swift
//  My JobneyTests
//
//  Created by Iurii Zisin on 1/2/24.
//

import SwiftUI


@propertyWrapper
class TestBinding<T>: DynamicProperty {
    var wrappedValue: T
    
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
    
    var projectedValue: Binding<T> {
        let defaultValue = wrappedValue
        return .init { [weak self] in
            self?.wrappedValue ?? defaultValue
        } set: { [weak self] newValue in
            self?.wrappedValue = newValue
        }
    }
}
