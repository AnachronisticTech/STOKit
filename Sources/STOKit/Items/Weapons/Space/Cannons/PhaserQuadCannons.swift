public class PhaserQuadCannons: CannonWeapon {
    public convenience init(_ mark: Mark, _ quality: Quality = .VeryRare) {
        self.init(.Quad, .Phaser, mark, quality)
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

    public override var description: String {
        return "\(damageType) \(weaponType) - Mk \(mark) \(quality)"
    }
}
