//
//  UIResponderEnvironment.swift
//  Created by Shawn Throop on 30.12.23.
//

import SwiftUI

@propertyWrapper public struct UIResponderEnvironment<Backing: UIResponder> : DynamicProperty {

    @Environment(UIResponderBackingStore.self) private var store
    
    public init() {}
    
    public var wrappedValue: Backing? {
        store.target as? Backing
    }
    
    public var projectedValue: UIResponderBackingStore {
        store
    }
}


public extension EnvironmentValues {
    
    func setResponder<T: UIResponder>(_ responder: T) {
        self[UIResponderBackingStore.self]?.target = responder
    }
}
