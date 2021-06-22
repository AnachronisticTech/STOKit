public class FleetImperialIntelAssaultCruiserT6: Starship {
    public override var className: String {
        "Fleet Imperial Intel Assault Cruiser T6"
    }

    public init(_ name: String) {
        super.init(
            name: name,
            foreWeapons: 4,
            rearWeapons: 4,
            engConsoles: 5,
            sciConsoles: 2,
            tacConsoles: 4
        )
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        super.init(
            name: name,
            foreWeapons: 4,
            rearWeapons: 4,
            engConsoles: 5,
            sciConsoles: 2,
            tacConsoles: 4
        )
        try super.decodeLoadout(from: container)
    }
}
