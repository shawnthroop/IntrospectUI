//
//  UIResponderState.swift
//  Created by Shawn Throop on 30.12.23.
//

import SwiftUI

@propertyWrapper public struct UIResponderState<Value: UIResponder> : DynamicProperty {
    
    @State private var storage = UIResponderBackingStore()
    
    public init() {}
    
    public var wrappedValue: Value? {
        storage.target as? Value
    }
    
    public var projectedValue: UIResponderBackingStore {
        storage
    }
}

public typealias UIResponderBackingStore = UIBackingStore<UIResponder>
