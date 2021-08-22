import Foundation
import SwiftUI

struct CodableButton: View, CodableViewVariant {
    var id: UUID = UUID()
    var content: String
    
    var body: some View {
        Button(content) {
            print("\(content) pressed")
        }
    }
}
