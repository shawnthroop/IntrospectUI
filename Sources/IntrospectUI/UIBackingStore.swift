//
//  UIBackingStore.swift
//  Created by Shawn Throop on 02.01.24.
//

import Foundation
import Observation

@Observable public class UIBackingStore<Value: AnyObject> {
    
    public weak var target: Value?
    
    public init() {}
}
