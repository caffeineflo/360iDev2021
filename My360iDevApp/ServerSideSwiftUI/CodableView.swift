import Foundation
import SwiftUI

protocol CodableViewVariant: Decodable {
    var id: UUID { get }
}

@dynamicMemberLookup
enum CodableView {
    case list(CodableList)
    case text(CodableText)
    case button(CodableButton)
    case image(CodableImage)
    case vStack(CodableVStack)
}

extension CodableView {
    subscript<T>(dynamicMember keyPath: KeyPath<CodableViewVariant, T>) -> T {
        switch self {
        case let .list(list):
            return list[keyPath: keyPath]
        case let .text(text):
            return text[keyPath: keyPath]
        case let .button(button):
            return button[keyPath: keyPath]
        case let .image(image):
            return image[keyPath: keyPath]
        case let .vStack(vStack):
            return vStack[keyPath: keyPath]
        }
    }
}

extension CodableView: Decodable {
    enum CodingKeys: CodingKey {
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        
        switch type {
        case "list":
            self = .list(try CodableList(from: decoder))
        case "text":
            self = .text(try CodableText(from: decoder))
        case "button":
            self = .button(try CodableButton(from: decoder))
        case "image":
            self = .image(try CodableImage(from: decoder))
        case "vStack":
            self = .vStack(try CodableVStack(from: decoder))
        default:
            fatalError("Unknown Type received")
        }
    }
}
