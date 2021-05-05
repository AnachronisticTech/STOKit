internal protocol ItemBase: Codable, CustomStringConvertible {
    var mark: Mark { get }
    var quality: Quality { get }

    var description: String { get }
}

internal protocol Specializable {
    associatedtype Keys: CodingKey

    static func decode(container: KeyedDecodingContainer<Keys>) -> Self?
}

open class Item: ItemBase, Specializable {
    typealias Keys = ItemCodingKeys

    public let mark: Mark
    public let quality: Quality

    internal init(mark: Mark, quality: Quality) {
        self.mark = mark
        self.quality = quality
    }

    public var description: String {
        return "Abstract item"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(String(describing: type(of: self)), forKey: .class)
        try container.encode(mark, forKey: .mark)
        try container.encode(quality, forKey: .quality)
    }
    
    internal class func decode(container: KeyedDecodingContainer<Keys>) -> Self? {
        // Modify this function when adding new item types
        if let item = Weapon.decode(container: container) as? Self {
            return item
        } else if let item = Console.decode(container: container) as? Self {
            return item
        } else if let item = Deflector.decode(container: container) as? Self {
            return item
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
