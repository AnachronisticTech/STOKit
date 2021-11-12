internal protocol ItemBase: Codable, CustomStringConvertible {
    var quality: Quality { get }

    var description: String { get }
}

internal protocol Specializable {
    associatedtype Keys: CodingKey

    static func decode(container: KeyedDecodingContainer<Keys>) -> Self?
}

open class Item: ItemBase, Specializable {
    typealias Keys = ItemCodingKeys

    public let quality: Quality

    internal init(quality: Quality) {
        self.quality = quality
    }

    public var description: String {
        return "Abstract item"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(String(describing: type(of: self)), forKey: .class)
        try container.encode(quality, forKey: .quality)
        if let item = self as? Markable {
            try container.encode(item.mark, forKey: .mark)
        }
    }
    
    internal class func decode(container: KeyedDecodingContainer<Keys>) -> Self? {
        // Modify this function when adding new item types
        let types: [Item.Type] = [
            Weapon.self,
            Console.self,
            Deflector.self
        ]
        for subtype in types {
            if let item = subtype.decode(container: container) as? Self {
                return item
            }
        }

        return nil
    }
}

enum ItemCodingKeys: String, CodingKey {
    // Keys for all items
    case mark, quality, `class`

    // Keys unique to weapons
    case _weaponType = "weaponType"
    case _damageType = "damageType"
}
