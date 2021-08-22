//
//  ViewFactory.swift
//  My360iDevApp
//
//  Created by Florian Harr on 8/21/21.
//

import Foundation
import SwiftUI

struct ViewFactory {
    @ViewBuilder
    static func view(for codableView: CodableView) -> some View {
        switch codableView {
        case let .list(codableListView):
            codableListView
        case let .text(codableTextView):
            codableTextView
        case let .button(codableButtonView):
            codableButtonView
        case let .image(codableImage):
            codableImage
        case let .vStack(codableVStack):
            codableVStack
        }
    }
}
