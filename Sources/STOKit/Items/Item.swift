public protocol Item {
    var mark: Mark { get }
    var quality: Quality { get }
}

enum ItemCodingKeys: String, CodingKey {
    case mark, quality, `class`
}
