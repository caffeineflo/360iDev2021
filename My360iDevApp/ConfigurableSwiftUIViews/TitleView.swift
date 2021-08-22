//
//  TitleView.swift
//  My360iDevApp
//
//  Created by Florian Harr on 8/20/21.
//

import Foundation
import SwiftUI

struct TitleView: View {
    var title: String

    var body: some View {
        Text(title)
            .font(.headline)
            .italic()
            .foregroundColor(.blue)
    }
}

#if DEBUG
struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "Hello 360iDev").previewAsComponent()
    }
}
#endif
