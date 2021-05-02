open class Deflector: Item {
    public required override init(mark: Mark, quality: Quality) {
        super.init(mark: mark, quality: quality)
    }

    public required init(from decoder: Decoder) throws {
        fatalError("This shouldn't ever be used")
    }

    public override var description: String {
        return "- Mk \(mark) \(quality)"
    }

    internal static func decode<C: Deflector>(from container: KeyedDecodingContainer<ItemCodingKeys>, as type: C.Type) throws -> C {
        let mark = try container.decode(Mark.self, forKey: .mark)
        let quality = try container.decode(Quality.self, forKey: .quality)
        return type.init(mark: mark, quality: quality)
    }
}
