public class FieldGenerator: ScienceConsole {
    public required init(_ mark: Mark, _ quality: Quality) {
        super.init(mark, quality)
    }

    public required init(from decoder: Decoder) throws {
        fatalError("This shouldn't ever be used")
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ItemCodingKeys.self)
        try container.encode(String(describing: type(of: self)), forKey: .class)
        try super.encode(to: encoder)
    }

    public override var description: String {
        return "Field Generator \(super.description)"
    }
}
