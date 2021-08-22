import Foundation
import SwiftUI

extension TextAlignment {
    enum JSONTextAlignment: String, Decodable {
        case leading
        case center
        case trailing
    }
    
    init(from json: JSONTextAlignment) {
        switch json {
        case .center:
            self = .center
        case .leading:
            self = .leading
        case .trailing:
            self = .trailing
        }
    }
}

extension TextAlignment: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(JSONTextAlignment.self)
        self.init(from: value)
    }
}
