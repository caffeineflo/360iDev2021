import Foundation
import SwiftUI

struct CodableList: View, CodableViewVariant {
    var id: UUID
    var views: [CodableView]
    
    var body: some View {
        List {
            ForEach(views, id: \.id) {
                ViewFactory.view(for: $0)
            }
        }
    }
}
