open class EngineeringConsole: Console {
    public let mark: Mark
    public let quality: Quality

    public required init(_ mark: Mark, _ quality: Quality) {
        self.mark = mark
        self.quality = quality
    }

    public var description: String {
        return "- Mk \(mark) \(quality)"
    }

    internal static func decode<C: EngineeringConsole>(from container: KeyedDecodingContainer<ConsoleCodingKeys>, as type: C.Type) throws -> C {
        let mark = try container.decode(Mark.self, forKey: .mark)
        let quality = try container.decode(Quality.self, forKey: .quality)
        return type.init(mark, quality)
    }

    internal static let specialTypes: [String: EngineeringConsole.Type] = {
        return _specialTypes.reduce([String: EngineeringConsole.Type]()) { (dict, type) -> [String: EngineeringConsole.Type] in
            var dict = dict
            dict[String(describing: type.self)] = type.self
            return dict
        }
    }()
    private static let _specialTypes: [EngineeringConsole.Type] = [
        NeutroniumAlloy.self
    ]
}
