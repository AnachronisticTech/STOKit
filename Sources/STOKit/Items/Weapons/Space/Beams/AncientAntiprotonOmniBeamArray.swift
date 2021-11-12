public class AncientAntiprotonOmniBeamArray: BeamWeapon {
    public convenience init(_ mark: Mark = .XII, _ quality: Quality = .VeryRare) {
        self.init(.OmnidirectionalBeamArray, .Antiproton, mark, quality)
    }

    internal required init(
        _ weaponType: BeamWeaponType, 
        _ damageType: EnergyDamageType, 
        _ mark: Mark, 
        _ quality: Quality
    ) {
        super.init(.OmnidirectionalBeamArray, .Antiproton, mark, quality)
    }

    public required init(from decoder: Decoder) throws {
        fatalError("This shouldn't ever be used")
    }

    public override var description: String {
        return "Ancient \(weaponType) - \(mark) \(quality)"
    }
}
