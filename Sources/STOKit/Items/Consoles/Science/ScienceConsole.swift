open class ScienceConsole: Console {
    public required init(_ mark: Mark, _ quality: Quality) {
        super.init(mark: mark, quality: quality)
    }

    public override var description: String {
        return "- Mk \(mark) \(quality)"
    }

    public required init(from decoder: Decoder) throws {
        fatalError("You cannot instantiate an abstract console")
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ItemCodingKeys.self)
        try container.encode(String(describing: type(of: self)), forKey: .class)
        try super.encode(to: encoder)
    }

    internal static func decode<C: ScienceConsole>(from container: KeyedDecodingContainer<ItemCodingKeys>, as type: C.Type) throws -> C {
        let mark = try container.decode(Mark.self, forKey: .mark)
        let quality = try container.decode(Quality.self, forKey: .quality)
        return type.init(mark, quality)
    }

    internal override class func decode(container: KeyedDecodingContainer<Keys>) -> Self? {
        guard
            let className = try? container.decode(String.self, forKey: .class),
            let type = specialTypes[className],
            let item = try? decode(from: container, as: type) as? Self
        else {
            return nil
        }
        return item
    }
}
