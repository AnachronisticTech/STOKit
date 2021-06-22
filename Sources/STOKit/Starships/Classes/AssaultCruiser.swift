public class AssaultCruiser: Starship {
    public override var className: String { "Assault Cruiser" }

    public init(_ name: String) {
        super.init(
            name: name,
            foreWeapons: 4,
            rearWeapons: 4,
            engConsoles: 4,
            sciConsoles: 2,
            tacConsoles: 3
        )
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        super.init(
            name: name,
            foreWeapons: 4,
            rearWeapons: 4,
            engConsoles: 4,
            sciConsoles: 2,
            tacConsoles: 3
        )
        try super.decodeLoadout(from: container)
    }
}
