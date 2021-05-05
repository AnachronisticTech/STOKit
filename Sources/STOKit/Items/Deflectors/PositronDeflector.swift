public class PositronDeflector: Deflector {
    public convenience init(_ mark: Mark, _ quality: Quality) {
        self.init(mark: mark, quality: quality)
    }

    internal required init(mark: Mark, quality: Quality) {
        super.init(mark: mark, quality: quality)
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
        return "Positron Deflector \(super.description)"
    }
}
