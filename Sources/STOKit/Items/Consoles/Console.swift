public protocol Console: Item, CustomStringConvertible, Codable {}

enum ConsoleCodingKeys: String, CodingKey {
    case mark, quality, `class`
}
