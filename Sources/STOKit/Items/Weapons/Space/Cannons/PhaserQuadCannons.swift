public class PhaserQuadCannons: CannonWeapon {
    public init(_ mark: Mark, _ quality: Quality) {
        super.init(.Quad, .Phaser, mark, quality)
    }

    internal required init(
        _ weaponType: CannonWeaponType, 
        _ damageType: EnergyDamageType, 
        _ mark: Mark, 
        _ quality: Quality
    ) {
        super.init(.Quad, .Phaser, mark, quality)
    }

    public required init(from decoder: Decoder) throws {
        fatalError("This shouldn't ever be used")
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: WeaponCodingKeys.self)
        try container.encode(String(describing: type(of: self)), forKey: .class)
        try super.encode(to: encoder)
    }

    public override var description: String {
        return "\(damageType) \(weaponType) - Mk \(mark) \(quality)"
    }
}
