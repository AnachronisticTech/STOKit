internal protocol ItemBase: Codable, CustomStringConvertible {
    var mark: Mark { get }
    var quality: Quality { get }

    var description: String { get }
}

open class Item: ItemBase {
    public let mark: Mark
    public let quality: Quality

    internal init(mark: Mark, quality: Quality) {
        self.mark = mark
        self.quality = quality
    }

    public var description: String {
        return "Abstract item"
    }
}

enum ItemCodingKeys: String, CodingKey {
    case mark, quality, `class`
}
