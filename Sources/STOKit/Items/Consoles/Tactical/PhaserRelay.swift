public class PhaserRelay: TacticalConsole {
    public required init(_ mark: Mark, _ quality: Quality) {
        super.init(mark, quality)
    }

    public required init(from decoder: Decoder) throws {
        fatalError("This shouldn't ever be used")
    }

    public override var description: String {
        return "Phaser Relay \(super.description)"
    }
}
