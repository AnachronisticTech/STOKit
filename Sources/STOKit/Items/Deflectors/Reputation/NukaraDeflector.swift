public class NukaraDeflector: Deflector {
    public required init(_ mark: Mark = .XII, _ quality: Quality = .VeryRare) {
        super.init(mark, quality)
    }

    public required init(from decoder: Decoder) throws {
        fatalError("This shouldn't ever be used")
    }

    public override var description: String {
        return "Nukara \(super.description)"
    }
}