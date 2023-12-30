//
//  UIResponderReader.swift
//  Created by Shawn Throop on 30.12.23.
//

import SwiftUI

public struct UIResponderReader<Responder: UIResponder, Content: View> : View {
    
    @UIResponderState var responder: Responder?
    
    let content: (Responder?) -> Content
    
    
    public init(of _: Responder.Type = UIResponder.self, @ViewBuilder content: @escaping (Responder?) -> Content) {
        self.content = content
    }
    
    public var body: some View {
        content(responder)
            .introspect { parent in
                if responder == nil, let target = parent?.findResponder(of: Responder.self) {
                    $responder.target = target
                }
            }
            .environment($responder)
    }
}


public extension UIResponder {
    
    /// Finds the nearest UIResponder of the provided Type.
    /// - Note: UIApplication's connectedScenes, UIWindowScene's rootViewController, UIViewController's children, and UIView's subviews are searched recursively.
    func findResponder<T: UIResponder>(of _: T.Type) -> T? {
        if isKind(of: T.self) {
            return self as? T
        }
        
        switch self {
        case let controller as UIViewController:
            if T.isSubclass(of: UIView.self) {
                if let found = controller.view.findResponder(of: T.self) {
                    return found
                }
            }
            
            for child in controller.children {
                if let found = child.findResponder(of: T.self) {
                    return found
                }
            }
            
        case let view as UIView:
            for subview in view.subviews {
                if let found = subview.findResponder(of: T.self) {
                    return found
                }
            }
            
        case let scene as UIWindowScene:
            if let window = scene.keyWindow, let found = window.rootViewController?.findResponder(of: T.self) {
                return found
            }
            
        case let application as UIApplication:
            for case let scene as UIWindowScene in application.connectedScenes {
                if let found = scene.findResponder(of: T.self) {
                    return found
                }
            }
            
        default:
            break
        }
        
        return nil
    }
}
