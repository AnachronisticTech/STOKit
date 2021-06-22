public class LightCruiser: Starship {
    public override var className: String { "Light Cruiser" }

    public override var canEquipDualCannons: Bool { true }

    public init(_ name: String) {
        super.init(
            name: name,
            foreWeapons: 2,
            rearWeapons: 1,
            engConsoles: 1,
            sciConsoles: 1,
            tacConsoles: 1
        )
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        super.init(
            name: name,
            foreWeapons: 2,
            rearWeapons: 1,
            engConsoles: 1,
            sciConsoles: 1,
            tacConsoles: 1
        )
        try super.decodeLoadout(from: container)
    }
}
