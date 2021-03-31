public class LightCruiser: Starship {
    public override var className: String {
        "Light Cruiser"
    }

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

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Starship.CodingKeys.self)
        try container.encode(String(describing: type(of: self)), forKey: .class)
        try super.encode(to: encoder)
    }
}
