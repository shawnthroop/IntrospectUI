//
//  GeometryReader.swift
//  Created by Shawn Throop on 01.01.24.
//

import SwiftUI

public extension View {
    
    func onGeometryChange<V: Equatable>(_ keyPath: KeyPath<GeometryProxy, V>, initial: Bool = false, _ action: @escaping (V, V) -> Void) -> some View {
        onGeometryChange { proxy in
            Color.clear
                .onChange(of: proxy[keyPath: keyPath], initial: initial, action)
        }
    }
    
    func onGeometryChange(perform action: @escaping (GeometryProxy) -> some View) -> some View {
        background {
            GeometryReader(content: action)
        }
    }
}
