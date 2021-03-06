public class TempestTailGun: CannonWeapon {
    override var isForeWeapon: Bool { false }
    override var isRearWeapon: Bool { true }

    public convenience init(_ mark: Mark = .Infinity, _ quality: Quality = .Epic) {
        self.init(.Dual, .Phaser, mark, quality)
    }

    internal required init(
        _ weaponType: CannonWeaponType,
        _ damageType: EnergyDamageType,
        _ mark: Mark,
        _ quality: Quality
    ) {
        super.init(.Dual, .Phaser, mark, quality)
    }

    public required init(from decoder: Decoder) throws {
        fatalError("This shouldn't ever be used")
    }

    public override var description: String {
        return "Tempest Tail Gun - \(mark) \(quality)"
    }
}
