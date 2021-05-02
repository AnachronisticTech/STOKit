open class TacticalConsole: Console {
    public required init(_ mark: Mark, _ quality: Quality) {
        super.init(mark: mark, quality: quality)
    }

    public override var description: String {
        return "- Mk \(mark) \(quality)"
    }

    public required init(from decoder: Decoder) throws {
        fatalError("You cannot instantiate an abstract console")
    }

    internal static func decode<C: TacticalConsole>(from container: KeyedDecodingContainer<ItemCodingKeys>, as type: C.Type) throws -> C {
        let mark = try container.decode(Mark.self, forKey: .mark)
        let quality = try container.decode(Quality.self, forKey: .quality)
        return type.init(mark, quality)
    }
}
