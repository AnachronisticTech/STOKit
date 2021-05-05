public class RevolutionaryDeflector: Deflector {
    public required init(_ mark: Mark = .II, _ quality: Quality = .VeryRare) {
        super.init(mark, quality)
    }

    public required init(from decoder: Decoder) throws {
        fatalError("This shouldn't ever be used")
    }

    public override var description: String {
        return "Revolutionary \(super.description)"
    }
}