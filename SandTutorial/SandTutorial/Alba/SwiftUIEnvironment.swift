//
//  SwiftUIEnvironment.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/31.
//

import Foundation
import SwiftUI

extension UIApplication {
    func hideKeyboard() {
        guard let window = windows.first else { return }
        let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapRecognizer.cancelsTouchesInView = false
        tapRecognizer.delegate = self
        window.addGestureRecognizer(tapRecognizer)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

extension View {
    func clearModalBackground() -> some View {
        modifier(ClearBackgroundViewModifier())
    }
}

struct ClearBackgroundViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.background(SimpleViewRepresenter { _ in
            let view = UIView()
            DispatchQueue.main.async {
                view.superview?.superview?.backgroundColor = .clear
            }
            return view
        })
    }
}

struct SimpleViewRepresenter<SimpleView: UIView>: UIViewRepresentable {
    typealias UIViewType = SimpleView
    
    let view: @MainActor (Context) -> SimpleView
    var update: @MainActor (SimpleView, Context) -> () = { _, _ in }
    
    func makeUIView(context: Context) -> SimpleView {
        view(context)
    }
    
    func updateUIView(_ uiView: SimpleView, context: Context) {
        update(uiView, context)
    }
}
