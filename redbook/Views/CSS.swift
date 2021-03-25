//
//  Constants.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 27/02/2021.
//

import Foundation
import UIKit
import SwiftUI

// this name is a joke, should probably change it 🤣
struct CSS {
  static let cardCornerRadius: CGFloat = 4
}

struct ActivityIndicator: UIViewRepresentable {

    typealias UIViewType = UIActivityIndicatorView

    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> ActivityIndicator.UIViewType {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: ActivityIndicator.UIViewType, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}
