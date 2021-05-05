public class TalShiarTachyonDeflector: Deflector {
    public required init(_ mark: Mark = .XI, _ quality: Quality = .Rare) {
        super.init(mark, quality)
    }

    public required init(from decoder: Decoder) throws {
        fatalError("This shouldn't ever be used")
    }

    public override var description: String {
        return "Tal Shiar Tachyon \(super.description)"
    }
}