//
//  Listview.swift
//  My360iDevApp
//
//  Created by Florian Harr on 8/20/21.
//

import Foundation
import SwiftUI

struct Item: Hashable, Identifiable {
    let id: UUID = UUID()
    let title: String
}

struct ListView: View {
    var title: String
    var items: [Item]
    @Binding var selectedItem: Item?

    var body: some View {
        VStack {
            Text(title).bold()
            List(items, selection: $selectedItem) { item in
                TitleView(title: item.title)
            }
        }.font(.system(.body, design: .monospaced))
    }
}

#if DEBUG
struct ListView_Previews: PreviewProvider {
    static let items: [Item] = [.init(title: "Hello 360"),
                         .init(title: "Hello World"),
                         .init(title: "Bonjour 360")]
    
    static var previews: some View {
        ListView(title: "Greetings",
                 items: items,
                 selectedItem: .constant(items.first!)).previewAsComponent()
    }
}
#endif
