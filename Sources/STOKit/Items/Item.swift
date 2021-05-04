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

    internal class func decode(container: KeyedDecodingContainer<Keys>) -> Self? {
        return nil
    }
}

enum ItemCodingKeys: String, CodingKey {
    case mark, quality, `class`
}
