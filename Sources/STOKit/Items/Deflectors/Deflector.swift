open class Deflector: Item {
    public required init(_ mark: Mark = .I, _ quality: Quality = .Common) {
        super.init(mark: mark, quality: quality)
    }

    public required init(from decoder: Decoder) throws {
        fatalError("This shouldn't ever be used")
    }

    public override var description: String {
        return "Deflector Array - Mk \(mark) \(quality)"
    }

    private static func decode<C: Deflector>(from container: KeyedDecodingContainer<Keys>, as type: C.Type) throws -> C {
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
