public class AdvancedTachyonDeflector: Deflector {
    public required init(_ mark: Mark = .I, _ quality: Quality = .Common) {
        super.init(mark, quality)
    }

    public required init(from decoder: Decoder) throws {
        fatalError("This shouldn't ever be used")
    }

    public override var description: String {
        return "Advanced Tachyon \(super.description)"
    }
}
