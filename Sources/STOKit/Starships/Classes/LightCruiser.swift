public class LightCruiser: STOStarship {
    public init(_ name: String) {
        super.init(name: name, foreWeapons: 2, rearWeapons: 1)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        super.init(name: name, foreWeapons: 2, rearWeapons: 1)
        try super.decodeLoadout(from: container)
    }
}