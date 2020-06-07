//
//  ActivityIndicator.swift
//  MyMoney
//
//  Created by Pietro Dellino on 6/6/20.
//  Copyright © 2020 Pietro Dellino. All rights reserved.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

extension ActivityIndicator {
    init(style: UIActivityIndicatorView.Style) {
        self.init(isAnimating: Binding.constant(true), style: style)
    }

    init() {
        self.init(style: .medium)
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    @State static var loading = true

    static var previews: some View {
        ActivityIndicator(isAnimating: $loading, style: .medium)
    }
}
