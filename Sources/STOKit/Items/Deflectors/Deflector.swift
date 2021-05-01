open class Deflector: Item, Codable, CustomStringConvertible {
    public let mark: Mark
    public let quality: Quality

    public required init(_ mark: Mark, _ quality: Quality) {
        self.mark = mark
        self.quality = quality
    }

    public var description: String {
        return "- Mk \(mark) \(quality)"
    }

    internal static func decode<C: Deflector>(from container: KeyedDecodingContainer<ItemCodingKeys>, as type: C.Type) throws -> C {
        let mark = try container.decode(Mark.self, forKey: .mark)
        let quality = try container.decode(Quality.self, forKey: .quality)
        return type.init(mark, quality)
    }
}
