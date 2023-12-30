//
//  UIViewControllerReader.swift
//  Created by Shawn Throop on 30.12.23.
//

import SwiftUI

public struct ParentReader: UIViewControllerRepresentable {
    
    public typealias UIViewControllerType = ParentReaderViewController
    
    let action: (UIViewController?) -> Void
    
    
    public init(action: @escaping (UIViewController?) -> Void) {
        self.action = action
    }
    
    public func makeUIViewController(context: Context) -> UIViewControllerType {
        .init()
    }
    
    public func updateUIViewController(_ viewController: UIViewControllerType, context: Context) {
        viewController.action = action
    }
    
    public func sizeThatFits(_ proposal: ProposedViewSize, uiViewController: UIViewControllerType, context: Context) -> CGSize? {
        .zero
    }
}


public extension View {
    
    func introspect(_ action: @escaping (UIViewController?) -> Void) -> some View {
        overlay(alignment: .top) {
            ParentReader(action: action)
        }
    }
}

public final class ParentReaderViewController: UIViewController {
    
    var action: (UIViewController?) -> Void = { _ in }
    
    public override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        view.isUserInteractionEnabled = false
        action(parent)
    }
}
